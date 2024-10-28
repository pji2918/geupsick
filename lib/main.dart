import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import 'utilities/types/geupsickinfoclass.dart';
import 'utilities/functions.dart';
import 'utilities/getschoolinfo.dart';

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

  GeupsickInfo geupsick = GeupsickInfo();
  int gScore = 0;

  DateTime date = DateTime.now();

  String schoolCode = "";
  String ministryCode = "";

  @override
  void initState() {
    super.initState();
    loadAppData();
  }

  void saveAppData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("schoolCode", schoolCode);
    await prefs.setString("ministryCode", ministryCode);
  }

  void loadAppData() async {
    final prefs = await SharedPreferences.getInstance();
    schoolCode = prefs.getString("schoolCode") ?? "";
    ministryCode = prefs.getString("ministryCode") ?? "";
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
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ko', 'KR'),
          ],
          theme: ThemeData(
            colorScheme: light,
            fontFamily:
                defaultTargetPlatform == TargetPlatform.windows || kIsWeb
                    ? GoogleFonts.ibmPlexSansKr().fontFamily
                    : null,
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
            fontFamily:
                defaultTargetPlatform == TargetPlatform.windows || kIsWeb
                    ? GoogleFonts.ibmPlexSansKr().fontFamily
                    : null,
          ),
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(DateFormat("MM월 dd일").format(date)),
                actions: [
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    tooltip: "날짜 선택",
                    onPressed: () async {
                      date = (await showDatePicker(
                            locale: const Locale('ko', 'KR'),
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ) ??
                          date);
                      setState(() {
                        date = date;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.school),
                    tooltip: "학교 선택",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                          child: SchoolChanger(
                              schoolCode: schoolCode,
                              ministryCode: ministryCode),
                        ),
                        useRootNavigator: false,
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(() {
                              schoolCode = value[0];
                              ministryCode = value[1];
                              saveAppData();
                            });
                          }
                        },
                      );
                    },
                  )
                ],
              ),
              body: mainForm(),
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    idx = index;
                  });
                },
                selectedIndex: idx,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.breakfast_dining_outlined),
                    selectedIcon: Icon(Icons.breakfast_dining),
                    label: "아침",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.lunch_dining_outlined),
                    selectedIcon: Icon(Icons.lunch_dining),
                    label: "점심",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.dinner_dining_outlined),
                    selectedIcon: Icon(Icons.dinner_dining),
                    label: "저녁",
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Center mainForm() {
    return Center(
      child: Builder(
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: getMeal(date, schoolCode, ministryCode, idx),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        size: 50,
                      ),
                      Text(
                        "급식 정보를 불러올 수 없습니다",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  geupsick = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card.filled(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: printMeal(
                                geupsick,
                                date,
                                schoolCode,
                                ministryCode,
                                idx,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: getGScore(geupsick),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card.filled(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.data == -2) {
                            return SizedBox.shrink();
                          } else if (snapshot.hasError || snapshot.data == -1) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card.filled(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                ),
                              ),
                            );
                          } else {
                            gScore = snapshot.data!;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card.filled(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "G-Score:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          gScore.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
