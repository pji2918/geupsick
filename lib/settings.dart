import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

enum ModelSelection { openAI, google, anthropic, xAI, openAICompatible }

class _SettingsState extends State<Settings> {
  bool useGScore = false;
  String aiApiKey = "";
  String aiApiUrl = "";
  String aiModelName = "";
  ModelSelection modelSelection = ModelSelection.openAI;

  void loadData() async {
    SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final bool savedUseGScore = await prefs.getBool("useGScore") ?? false;
    final String savedAiApiKey = await prefs.getString("aiApiKey") ?? "";
    final String savedAiApiUrl = await prefs.getString("aiApiUrl") ?? "";
    final String savedAiModelName = await prefs.getString("aiModelName") ?? "";
    final ModelSelection savedModelSelection =
        ModelSelection.values[await prefs.getInt("modelSelection") ?? 0];

    if (!mounted) return;

    setState(() {
      useGScore = savedUseGScore;
      aiApiKey = savedAiApiKey;
      modelSelection = savedModelSelection;
      aiApiUrl = savedAiApiUrl;
      aiModelName = savedAiModelName;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void exit(BuildContext context) async {
    SharedPreferencesAsync prefs = SharedPreferencesAsync();

    await prefs.setBool("useGScore", useGScore);
    await prefs.setString("aiApiKey", aiApiKey);
    await prefs.setString("aiApiUrl", aiApiUrl);
    await prefs.setString("aiModelName", aiModelName);
    await prefs.setInt("modelSelection", modelSelection.index);
    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              exit(context);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.settings),
              leading: IconButton(
                onPressed: () {
                  exit(context);
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
                          subtitle: Text(
                            AppLocalizations.of(context)!.useGScoreDesc,
                          ),
                          value: useGScore,
                          onChanged: (value) => setState(() {
                            useGScore = value;
                          }),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.aiApiKeyTitle,
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!.aiApiKeyDesc,
                          ),
                          enabled: useGScore,
                          onTap: () {
                            String tempkey = aiApiKey;
                            TextEditingController textController =
                                TextEditingController(text: aiApiKey);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return aiApiKeyConfig(textController, tempkey);
                              },
                            ).then((value) {
                              setState(() {
                                aiApiKey = value ?? "";
                              });
                            });
                          },
                        ),
                        ListTile(
                          title: Text("openAIcompatibleSetting"),
                          subtitle: Text("openAIcompatibleSettingDesc"),
                          enabled:
                              modelSelection == ModelSelection.openAICompatible,
                          onTap: () {
                            String apiUrl = aiApiUrl;
                            String model = aiModelName;
                            TextEditingController textControllerOne =
                                TextEditingController(text: apiUrl);
                            TextEditingController textControllerTwo =
                                TextEditingController(text: model);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return openAICompatibleConfig(
                                  textControllerOne,
                                  textControllerTwo,
                                  apiUrl,
                                  model,
                                );
                              },
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  aiApiUrl = value[0];
                                  aiModelName = value[1];
                                });
                              }
                            });
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
                          subtitle: Text(
                            AppLocalizations.of(context)!.aboutDesc,
                          ),
                          onTap: () async {
                            PackageInfo packageInfo =
                                await PackageInfo.fromPlatform();
                            if (context.mounted) {
                              showAboutDialog(
                                context: context,
                                applicationName: packageInfo.appName,
                                applicationVersion: packageInfo.version,
                                applicationLegalese: "by pji2918",
                                applicationIcon: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      "급",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 48,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  StatefulBuilder openAICompatibleConfig(
    TextEditingController textControllerOne,
    TextEditingController textControllerTwo,
    String apiUrl,
    String model,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("openAiCompatibleConfig"),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.75,
            height: 200,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 6,
                  child: TextField(
                    autocorrect: false,
                    controller: textControllerOne,
                    decoration: InputDecoration(hintText: "baseUrl"),
                    onChanged: (value) => apiUrl = value,
                  ),
                ),
                Spacer(flex: 1),
                Flexible(
                  flex: 6,
                  child: TextField(
                    autocorrect: false,
                    controller: textControllerTwo,
                    decoration: InputDecoration(hintText: "modelName"),
                    onChanged: (value) => model = value,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                if (apiUrl.endsWith("/")) {
                  apiUrl = apiUrl.substring(0, apiUrl.length - 1);
                }
                Navigator.of(context).pop([apiUrl, model]);
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        );
      },
    );
  }

  StatefulBuilder aiApiKeyConfig(
    TextEditingController textController,
    String tempkey,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.aiApiKeyTitle),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.75,
            height: 400,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RadioGroup(
                  groupValue: modelSelection,
                  onChanged: (value) {
                    setState(() => modelSelection = value as ModelSelection);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("OpenAI"),
                        leading: Radio(value: ModelSelection.openAI),
                      ),
                      ListTile(
                        title: Text("Google"),
                        leading: Radio(value: ModelSelection.google),
                      ),
                      ListTile(
                        title: Text("Anthropic"),
                        leading: Radio(value: ModelSelection.anthropic),
                      ),
                      ListTile(
                        title: Text("xAI"),
                        leading: Radio(value: ModelSelection.xAI),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.openAICompatible,
                        ),
                        leading: Radio(value: ModelSelection.openAICompatible),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Text.rich(
                  style: TextStyle(fontSize: 12),
                  TextSpan(
                    text: AppLocalizations.of(context)!.getAiApiKey,
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.clickHere,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            switch (modelSelection) {
                              case ModelSelection.openAI:
                                {
                                  launchUrl(
                                    Uri.parse(
                                      "https://platform.openai.com/api-keys",
                                    ),
                                  );
                                  break;
                                }
                              case ModelSelection.google:
                                {
                                  launchUrl(
                                    Uri.parse(
                                      "https://aistudio.google.com/app/apikey",
                                    ),
                                  );
                                  break;
                                }
                              case ModelSelection.anthropic:
                                {
                                  launchUrl(
                                    Uri.parse(
                                      "https://console.anthropic.com/account/keys",
                                    ),
                                  );
                                  break;
                                }
                              case ModelSelection.xAI:
                                {
                                  launchUrl(Uri.parse("https://x.ai/api"));
                                  break;
                                }
                              case ModelSelection.openAICompatible:
                                {
                                  break;
                                }
                            }
                          },
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: textController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.aiApiKeyPlaceHolder,
                  ),
                  onChanged: (value) => tempkey = value,
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                  autocorrect: false,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(aiApiKey),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(tempkey),
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        );
      },
    );
  }
}
