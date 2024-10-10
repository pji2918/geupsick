import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(MainApp());
}

Future<List<dynamic>> getMeal() async {
  var url = Uri.parse(
      "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=ec86c034134b4479bcbdf413fa3f2288&Type=json&ATPT_OFCDC_SC_CODE=R10&SD_SCHUL_CODE=8750767&MLSV_YMD=${DateFormat('yyyyMMdd').format(DateTime.now())}");
  var data = json.decode(await http.get(url).then((value) => value.body));
  if (data != null && data["mealServiceDietInfo"] != null) {
    List<dynamic> meals = data["mealServiceDietInfo"][1]["row"];
    return meals;
  } else {
    return [];
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int idx = 0;
  List<dynamic>? geupsick;

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
        children: [],
      );
      List<String> meal = geupsick![idx]["DDISH_NM"].toString().split("<br/>");
      for (int i = 0; i < meal.length; i++) {
        col.children.add(Text("* ${meal[i]}"));
      }
      return col;
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme light;
        ColorScheme dark;

        if (lightDynamic != null && darkDynamic != null) {
          light = lightDynamic.harmonized();
          dark = darkDynamic.harmonized();
        } else {
          light = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          dark = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "급식",
          theme: ThemeData(
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                DateFormat("yyyy년 MM월 dd일").format(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: printMeal(),
                ),
              ),
            ),
            bottomNavigationBar: NavigationBar(
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
            ),
          ),
        );
      },
    );
  }
}
