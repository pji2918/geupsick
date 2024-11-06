import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    if (date.hour <= 9) {
      idx = 0;
    } else if (date.hour <= 13) {
      idx = 1;
    } else {
      idx = 2;
    }
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
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          title: "Geupsick",
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
          home: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    DateFormat.MMMd(
                      Localizations.localeOf(context).languageCode,
                    ).format(date),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      tooltip: AppLocalizations.of(context)!.dateSelect,
                      onPressed: () async {
                        date = await showDatePicker(
                              locale: Localizations.localeOf(context),
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            ) ??
                            date;
                        setState(() => date = date);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.school),
                      tooltip: AppLocalizations.of(context)!.schoolSelect,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                          child: SchoolChanger(
                            schoolCode: schoolCode,
                            ministryCode: ministryCode,
                          ),
                        ),
                        useRootNavigator: false,
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(
                              () {
                                schoolCode = value[0];
                                ministryCode = value[1];
                                saveAppData();
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                body: isMediumScreen(context)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!isLargeScreen(context))
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: NavigationRail(
                                labelType: NavigationRailLabelType.all,
                                destinations: [
                                  NavigationRailDestination(
                                    icon: Icon(Icons.breakfast_dining_outlined),
                                    selectedIcon: Icon(Icons.breakfast_dining),
                                    label: Text(
                                      AppLocalizations.of(context)!.breakfast,
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.lunch_dining_outlined),
                                    selectedIcon: Icon(Icons.lunch_dining),
                                    label: Text(
                                      AppLocalizations.of(context)!.lunch,
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.dinner_dining_outlined),
                                    selectedIcon: Icon(Icons.dinner_dining),
                                    label: Text(
                                      AppLocalizations.of(context)!.dinner,
                                    ),
                                  ),
                                ],
                                selectedIndex: idx,
                                onDestinationSelected: (value) =>
                                    setState(() => idx = value),
                              ),
                            )
                          else
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Drawer(
                                child: Column(
                                  children: [
                                    // DrawerHeader(
                                    //   child: Center(
                                    //     child: Text(
                                    //       "급식",
                                    //       style: TextStyle(
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize: 30,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    ListTile(
                                      leading: Icon(Icons.breakfast_dining),
                                      title: Text(
                                        AppLocalizations.of(context)!.breakfast,
                                      ),
                                      selected: idx == 0,
                                      onTap: () => setState(() => idx = 0),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.lunch_dining),
                                      title: Text(
                                        AppLocalizations.of(context)!.lunch,
                                      ),
                                      selected: idx == 1,
                                      onTap: () => setState(() => idx = 1),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.dinner_dining),
                                      title: Text(
                                        AppLocalizations.of(context)!.dinner,
                                      ),
                                      selected: idx == 2,
                                      onTap: () => setState(() => idx = 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: mainForm(),
                          ),
                        ],
                      )
                    : mainForm(),
                bottomNavigationBar:
                    !isMediumScreen(context) && !isLargeScreen(context)
                        ? NavigationBar(
                            onDestinationSelected: (int index) =>
                                setState(() => idx = index),
                            selectedIndex: idx,
                            destinations: [
                              NavigationDestination(
                                icon: Icon(Icons.breakfast_dining_outlined),
                                selectedIcon: Icon(Icons.breakfast_dining),
                                label: AppLocalizations.of(context)!.breakfast,
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.lunch_dining_outlined),
                                selectedIcon: Icon(Icons.lunch_dining),
                                label: AppLocalizations.of(context)!.lunch,
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.dinner_dining_outlined),
                                selectedIcon: Icon(Icons.dinner_dining),
                                label: AppLocalizations.of(context)!.dinner,
                              ),
                            ],
                          )
                        : null,
              );
            },
          ),
        );
      },
    );
  }

  Widget mainForm() {
    return FutureBuilder(
      future: getMeal(date, schoolCode, ministryCode, idx),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
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
                AppLocalizations.of(context)!.errorMessage,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: getPadding(context),
                child: Card.filled(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: printMeal(
                      geupsick,
                      date,
                      schoolCode,
                      ministryCode,
                      idx,
                      context,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: getGScore(geupsick),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: getPadding(context),
                      child: SizedBox(
                        child: Card.filled(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.data == -2) {
                    return SizedBox.shrink();
                  } else if (snapshot.hasError || snapshot.data == -1) {
                    return Padding(
                      padding: getPadding(context),
                      child: SizedBox(
                        child: Card.filled(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
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
                                  AppLocalizations.of(context)!
                                      .errorMessage_GScore,
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
                      padding: getPadding(context),
                      child: SizedBox(
                        child: Card.filled(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "G-Score:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                                ),
                                Card.filled(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      gScore.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
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
    );
  }
}
