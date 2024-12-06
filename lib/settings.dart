import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool useGScore = false;
  String openAIApiKey = "";

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then(
      (value) {
        setState(() {
          useGScore = value.getBool("useGScore") ?? false;
          openAIApiKey = value.getString("openAIApiKey") ?? "";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.settings),
            leading: IconButton(
              onPressed: () {
                SharedPreferences.getInstance().then(
                  (value) {
                    value.setBool("useGScore", useGScore);
                    value.setString("openAIApiKey", openAIApiKey);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
              icon: Icon(Icons.arrow_back),
              tooltip: "Go Back",
            ),
          ),
          body: SafeArea(
            top: false,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          "G-Score Settings",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        title: Text("Use G-Score"),
                        subtitle: Text("Whether Use G-Score."),
                        value: useGScore,
                        onChanged: (value) => setState(
                          () {
                            useGScore = value;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("OpenAI API Key"),
                        subtitle: Text("Enter Your OpenAI API Key Here."),
                        enabled: useGScore,
                        onTap: () {
                          String tempkey = openAIApiKey;
                          TextEditingController textController =
                              TextEditingController(text: openAIApiKey);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("OpenAI API Key"),
                                content: SizedBox(
                                  width: 250,
                                  height: 100,
                                  child: Center(
                                    child: TextField(
                                      controller: textController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Enter Your OpenAI API Key Here",
                                      ),
                                      onChanged: (value) => tempkey = value,
                                      onSubmitted: (value) {
                                        Navigator.of(context).pop(value);
                                      },
                                      autocorrect: false,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(openAIApiKey),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(tempkey),
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          ).then(
                            (value) {
                              openAIApiKey = value;
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          "General",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("About"),
                        subtitle: Text("Show About Screen."),
                        onTap: () async {
                          PackageInfo packageInfo =
                              await PackageInfo.fromPlatform();
                          if (context.mounted) {
                            showAboutDialog(
                              context: context,
                              applicationName: packageInfo.appName,
                              applicationVersion: packageInfo.version,
                              applicationLegalese: "by pji2918",
                              applicationIcon: Image.asset(
                                "assets/icon/icon.webp",
                                width: 100,
                                height: 100,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
