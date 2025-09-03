import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import 'settings.dart';
import 'utilities/types/geupsickinfoclass.dart';
import 'utilities/functions.dart';
import 'utilities/getschoolinfo.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(MainApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
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
    } else if (date.hour <= 19) {
      idx = 2;
    } else {
      date = date.add(Duration(days: 1));
      idx = 0;
    }
  }

  void saveAppData() async {
    SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString("schoolCode", schoolCode);
    await prefs.setString("ministryCode", ministryCode);
  }

  void loadAppData() async {
    SharedPreferencesAsync prefs = SharedPreferencesAsync();
    schoolCode = await prefs.getString("schoolCode") ?? "";
    ministryCode = await prefs.getString("ministryCode") ?? "";
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
          light = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          dark = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          scrollBehavior: AppScrollBehavior(),
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
                    DateFormat.MMMEd(
                      Localizations.localeOf(context).languageCode,
                    ).format(date),
                  ),
                  actions: [
                    MenuAnchor(
                      menuChildren: [
                        MenuItemButton(
                          child: SizedBox(
                            width: 125,
                            child: Wrap(
                              spacing: 5,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.calendar_month),
                                Text(AppLocalizations.of(context)!.dateSelect),
                              ],
                            ),
                          ),
                          onPressed: () async {
                            DateTime newDate =
                                await showDatePicker(
                                  locale: Localizations.localeOf(context),
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(1972, 11, 21),
                                  lastDate: DateTime(2222, 2, 22),
                                ) ??
                                date;
                            if (date != newDate) {
                              setState(() => date = newDate);
                            }
                          },
                        ),
                        MenuItemButton(
                          onPressed: () => selectSchool(context),
                          child: SizedBox(
                            width: 125,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5,
                              children: [
                                Icon(Icons.school),
                                Text(
                                  AppLocalizations.of(context)!.schoolSelect,
                                ),
                              ],
                            ),
                          ),
                        ),
                        MenuItemButton(
                          child: SizedBox(
                            width: 125,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5,
                              children: [
                                Icon(Icons.settings),
                                Text(AppLocalizations.of(context)!.settings),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settings(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                        ),
                      ],
                      builder: (_, controller, child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.more_vert),
                          tooltip: AppLocalizations.of(context)!.menu,
                        );
                      },
                    ),
                  ],
                ),
                body:
                    isMediumScreen(context)
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
                                      icon: Icon(
                                        Icons.breakfast_dining_outlined,
                                      ),
                                      selectedIcon: Icon(
                                        Icons.breakfast_dining,
                                      ),
                                      label: Text(
                                        AppLocalizations.of(context)!.breakfast,
                                      ),
                                      disabled: schoolCode.isEmpty,
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(Icons.lunch_dining_outlined),
                                      selectedIcon: Icon(Icons.lunch_dining),
                                      label: Text(
                                        AppLocalizations.of(context)!.lunch,
                                      ),
                                      disabled: schoolCode.isEmpty,
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(Icons.dinner_dining_outlined),
                                      selectedIcon: Icon(Icons.dinner_dining),
                                      label: Text(
                                        AppLocalizations.of(context)!.dinner,
                                      ),
                                      disabled: schoolCode.isEmpty,
                                    ),
                                  ],
                                  selectedIndex: idx,
                                  onDestinationSelected: (value) {
                                    if (idx != value) {
                                      setState(() => idx = value);
                                    }
                                  },
                                ),
                              )
                            else
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Drawer(
                                  child: ListView(
                                    children: [
                                      Column(
                                        children: [
                                          ListTile(
                                            enabled: schoolCode.isNotEmpty,
                                            leading: Icon(
                                              Icons.breakfast_dining,
                                            ),
                                            title: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.breakfast,
                                            ),
                                            selected: idx == 0,
                                            onTap: () {
                                              if (idx != 0) {
                                                setState(() => idx = 0);
                                              }
                                            },
                                          ),
                                          ListTile(
                                            enabled: schoolCode.isNotEmpty,
                                            leading: Icon(Icons.lunch_dining),
                                            title: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.lunch,
                                            ),
                                            selected: idx == 1,
                                            onTap: () {
                                              if (idx != 1) {
                                                setState(() => idx = 1);
                                              }
                                            },
                                          ),
                                          ListTile(
                                            enabled: schoolCode.isNotEmpty,
                                            leading: Icon(Icons.dinner_dining),
                                            title: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.dinner,
                                            ),
                                            selected: idx == 2,
                                            onTap: () {
                                              if (idx != 2) {
                                                setState(() => idx = 2);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Flexible(
                              flex: 7,
                              fit: FlexFit.tight,
                              child: mainForm(context),
                            ),
                          ],
                        )
                        : mainForm(context),
                bottomNavigationBar:
                    !isMediumScreen(context) && !isLargeScreen(context)
                        ? NavigationBar(
                          onDestinationSelected: (int index) {
                            if (idx != index) {
                              setState(() => idx = index);
                            }
                          },
                          selectedIndex: idx,
                          destinations: [
                            NavigationDestination(
                              enabled: schoolCode.isNotEmpty,
                              icon: Icon(Icons.breakfast_dining_outlined),
                              selectedIcon: Icon(Icons.breakfast_dining),
                              label: AppLocalizations.of(context)!.breakfast,
                            ),
                            NavigationDestination(
                              enabled: schoolCode.isNotEmpty,
                              icon: Icon(Icons.lunch_dining_outlined),
                              selectedIcon: Icon(Icons.lunch_dining),
                              label: AppLocalizations.of(context)!.lunch,
                            ),
                            NavigationDestination(
                              enabled: schoolCode.isNotEmpty,
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

  void selectSchool(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => Dialog.fullscreen(
            child: SchoolChanger(
              schoolCode: schoolCode,
              ministryCode: ministryCode,
            ),
          ),
      useRootNavigator: false,
    ).then((value) {
      if (value != null && schoolCode != value[0]) {
        setState(() {
          schoolCode = value[0];
          ministryCode = value[1];
          saveAppData();
        });
        idx = 0;
      }
    });
  }

  Widget mainForm(BuildContext context) {
    if (schoolCode.isEmpty) {
      return Padding(
        padding: getPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card.filled(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.schoolNotSelectedTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    Text(
                      AppLocalizations.of(context)!.schoolNotSelectedDesc,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    FilledButton(
                      onPressed: () => selectSchool(context),
                      child: Text(AppLocalizations.of(context)!.schoolSelect),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    final PageController pageController = PageController(initialPage: 999);

    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          if (value > pageController.page!) {
            date = date.add(Duration(days: 1));
          } else {
            date = date.add(Duration(days: -1));
          }
        });
      },
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: getMeal(
            date,
            schoolCode: schoolCode,
            ministryCode: ministryCode,
            idx,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: getPadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card.filled(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 50),
                  Text(
                    AppLocalizations.of(context)!.errorMessage,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              geupsick = snapshot.data!;
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: getPadding(context),
                        child: Card.filled(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: getPadding(context),
                              child: SizedBox(
                                child: Card.filled(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.data == -2) {
                            return SizedBox.shrink();
                          } else if (snapshot.hasError || snapshot.data == -1) {
                            debugPrint(snapshot.error.toString());
                            return Padding(
                              padding: getPadding(context),
                              child: SizedBox(
                                child: Card.filled(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.warning, size: 50),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.errorMessage_GScore,
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
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "G-Score:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                          ),
                                        ),
                                        Card.filled(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              gScore.toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.onSecondary,
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
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
