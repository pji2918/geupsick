import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int idx = 0;
  List<dynamic>? geupsick;

  DateTime date = DateTime.now();

  Future<List<dynamic>> getMeal() async {
    var url = Uri.parse(
        "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=ec86c034134b4479bcbdf413fa3f2288&Type=json&ATPT_OFCDC_SC_CODE=R10&SD_SCHUL_CODE=8750767&MLSV_YMD=${DateFormat('yyyyMMdd').format(date)}");
    var response = await http.get(url);
    var data = json.decode(response.body);
    if (data != null && data["mealServiceDietInfo"] != null) {
      List<dynamic> meals = data["mealServiceDietInfo"][1]["row"];
      return meals;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getMeal().then((data) {
      setState(() {
        geupsick = data;
      });
    });
  }

  printMeal() {
    if (geupsick != null) {
      Column col = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [Divider()],
      );

      List<String> meal = [];

      try {
        meal = geupsick![idx]["DDISH_NM"].toString().split("<br/>");
      } catch (e) {
        if (e is RangeError) {
          return Text("급식이 없습니다.", style: TextStyle(fontSize: 20));
        }
      }
      for (int i = 0; i < meal.length; i++) {
        col.children.add(Text(meal[i]));
        col.children.add(Divider());
      }

      return col;
    } else {
      return CircularProgressIndicator();
    }
  }

  Future<int> getGScore(int foodIdx) async {
    String meal = "";

    await getMeal().then((value) {
      if (value.length <= foodIdx) {
        meal = "-2";
      } else {
        meal = value[foodIdx]["DDISH_NM"].toString().replaceAll("<br/>", "\n");
      }
    });

    if (meal == "-2") {
      return -2;
    }

    OpenAI.apiKey =
        "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";
    OpenAI.requestsTimeOut = Duration(seconds: 15);
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "당신은 객관적으로 급식의 맛을 평가하는 인공지능입니다. 0부터 100까지의 숫자로 평가 점수를 반환하세요. 숫자 이외에 다른 문자를 포함하면 안 됩니다."
              "\n평가는 고기, 디저트, 카레, 튀김 등의 맛있는 음식이 많을 경우 점수가 올라갑니다."
              "\n생선이 포함된 음식이나 해산물, 채소가 많을 경우 점수가 내려갑니다."),
        ]);

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "다음은 오늘의 학교 급식이야. 평가해 줘: \n$meal"),
        ]);

    final requestMessages = [
      systemMessage,
      userMessage,
    ];

    OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
      model: "gpt-4o-mini",
      messages: requestMessages,
    );

    String responseText =
        completion.choices.first.message.content!.first.text ?? "-1";

    debugPrint(responseText);

    return int.parse(responseText);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme light;
        ColorScheme dark;

        if (lightDynamic != null && darkDynamic != null) {
          light = lightDynamic.harmonized();
          dark = darkDynamic.harmonized();
        } else {
          light = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          );
          dark = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "급식",
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('ko'),
          ],
          theme: ThemeData(
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
          ),
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  DateFormat("yyyy년 MM월 dd일").format(date),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () async {
                      date = (await showDatePicker(
                            locale: const Locale('ko', 'KR'),
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ) ??
                          date);
                      getMeal().then((data) {
                        // refresh meal
                        setState(() {
                          geupsick = data;
                        });

                        // refresh g-score
                        getGScore(idx).then((value) {
                          setState(() {});
                        });

                        // refresh title
                        setState(() {
                          date = date;
                        });
                      });
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: printMeal(),
                      ),
                    ),
                    FutureBuilder(
                        future: getGScore(idx),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Card(
                                child: Padding(
                              padding: EdgeInsets.all(50),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (snapshot.data == -2) {
                            return Container();
                          } else if (snapshot.hasError || snapshot.data == -1) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 50,
                                    ),
                                    Text(
                                      "급식 점수를 불러올 수 없습니다",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Column(
                                  children: [
                                    Text("G-Score:",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Divider(),
                                    Text(
                                      snapshot.data.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
              bottomNavigationBar: Builder(builder: (context) {
                return NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      idx = index;
                    });
                  },
                  selectedIndex: idx,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.breakfast_dining),
                      label: "아침",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.lunch_dining),
                      label: "점심",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.dinner_dining),
                      label: "저녁",
                    ),
                  ],
                );
              }),
            );
          }),
        );
      },
    );
  }
}
