import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

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
  int idx = DateTime.now().hour <= 8
      ? 0
      : DateTime.now().hour <= 13
          ? 1
          : 2;
  List<dynamic>? geupsick;

  DateTime date = DateTime.now();

  String schoolCode = "";
  String ministryCode = "";

  @override
  void initState() {
    super.initState();
    getMeal(date, schoolCode, ministryCode).then((data) {
      setState(() {
        geupsick = data;
      });
    });
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
            const Locale('en'),
            const Locale('ko'),
          ],
          theme: ThemeData(
            colorScheme: light,
            fontFamily: Platform.isWindows
                ? GoogleFonts.ibmPlexSansKr().fontFamily
                : null,
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
            fontFamily: Platform.isWindows
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
                      getMeal(date, schoolCode, ministryCode).then((data) {
                        if (date.day != DateTime.now().day) {
                          idx = 0;
                        } else {
                          idx = DateTime.now().hour <= 8
                              ? 0
                              : DateTime.now().hour <= 13
                                  ? 1
                                  : 2;
                        }

                        // refresh g-score
                        getGScore(idx, date, schoolCode, ministryCode)
                            .then((value) {
                          setState(() {});
                        });

                        // refresh title
                        setState(() {
                          date = date;
                        });
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      var result = showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                          child: SchoolChanger(
                              schoolCode: schoolCode,
                              ministryCode: ministryCode),
                        ),
                        useRootNavigator: false,
                      );
                      result.then((value) {
                        schoolCode = value[0];
                        ministryCode = value[1];
                      });
                      getMeal(date, schoolCode, ministryCode).then(
                        (data) => geupsick = data,
                      );

                      // refresh everything
                      setState(() {});
                    },
                    icon: Icon(Icons.school),
                    tooltip: "학교 선택",
                  )
                ],
              ),
              body: mainForm(),
              bottomNavigationBar: Builder(builder: (context) {
                return NavigationBar(
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
                );
              }),
            );
          }),
        );
      },
    );
  }

  Center mainForm() {
    return Center(
      child: Column(
        children: [
          Builder(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card.filled(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: printMeal(geupsick, idx),
                    ),
                  ),
                ),
              );
            },
          ),
          FutureBuilder(
              future: getGScore(idx, date, schoolCode, ministryCode),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card.filled(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.data == -2) {
                  return Container();
                } else if (snapshot.hasError || snapshot.data == -1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card.filled(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
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
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card.filled(
                        color: Theme.of(context).colorScheme.secondaryContainer,
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
                                snapshot.data.toString(),
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
              }),
        ],
      ),
    );
  }
}
