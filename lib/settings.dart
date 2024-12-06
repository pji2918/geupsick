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
              tooltip: AppLocalizations.of(context)!.goBack,
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
                          AppLocalizations.of(context)!.gscoreSection,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        title: Text(AppLocalizations.of(context)!.useGScore),
                        subtitle:
                            Text(AppLocalizations.of(context)!.useGScoreDesc),
                        value: useGScore,
                        onChanged: (value) => setState(
                          () {
                            useGScore = value;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                            AppLocalizations.of(context)!.openAIApiKeyTitle),
                        subtitle: Text(
                            AppLocalizations.of(context)!.openAIApiKeyDesc),
                        enabled: useGScore,
                        onTap: () {
                          String tempkey = openAIApiKey;
                          TextEditingController textController =
                              TextEditingController(text: openAIApiKey);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!
                                    .openAIApiKeyTitle),
                                content: SizedBox(
                                  width: 250,
                                  height: 100,
                                  child: Center(
                                    child: TextField(
                                      controller: textController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .openAIApiKeyPlaceHolder,
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
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(tempkey),
                                    child:
                                        Text(AppLocalizations.of(context)!.ok),
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
                          AppLocalizations.of(context)!.generalSection,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.about),
                        subtitle: Text(AppLocalizations.of(context)!.aboutDesc),
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
