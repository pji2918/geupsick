import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geupsick/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

enum ModelSelection { openAI, google, anthropic, xAI }

class _SettingsState extends State<Settings> {
  bool useGScore = false;
  String aiApiKey = "";
  ModelSelection modelSelection = ModelSelection.openAI;

  void loadData() async {
    SharedPreferencesAsync prefs = SharedPreferencesAsync();
    useGScore = await prefs.getBool("useGScore") ?? false;
    aiApiKey = await prefs.getString("aiApiKey") ?? "";
    modelSelection =
        ModelSelection.values[await prefs.getInt("modelSelection") ?? 0];
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
                          onChanged:
                              (value) => setState(() {
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
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.aiApiKeyTitle,
                                      ),
                                      content: SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                            0.75,
                                        height: 300,
                                        child: Column(
                                          children: [
                                            RadioGroup(
                                              groupValue: modelSelection,
                                              onChanged: (value) {
                                                setState(
                                                  () =>
                                                      modelSelection =
                                                          value
                                                              as ModelSelection,
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text("OpenAI"),
                                                    leading: Radio(
                                                      value:
                                                          ModelSelection.openAI,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text("Google"),
                                                    leading: Radio(
                                                      value:
                                                          ModelSelection.google,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text("Anthropic"),
                                                    leading: Radio(
                                                      value:
                                                          ModelSelection
                                                              .anthropic,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text("xAI"),
                                                    leading: Radio(
                                                      value: ModelSelection.xAI,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              style: TextStyle(fontSize: 12),
                                              TextSpan(
                                                text:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.getAiApiKey,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.clickHere,
                                                    style: TextStyle(
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            switch (modelSelection) {
                                                              case ModelSelection
                                                                  .openAI:
                                                                launchUrl(
                                                                  Uri.parse(
                                                                    "https://platform.openai.com/api-keys",
                                                                  ),
                                                                );
                                                                break;
                                                              case ModelSelection
                                                                  .google:
                                                                launchUrl(
                                                                  Uri.parse(
                                                                    "https://aistudio.google.com/app/apikey",
                                                                  ),
                                                                );
                                                                break;
                                                              case ModelSelection
                                                                  .anthropic:
                                                                launchUrl(
                                                                  Uri.parse(
                                                                    "https://console.anthropic.com/account/keys",
                                                                  ),
                                                                );
                                                                break;
                                                              case ModelSelection
                                                                  .xAI:
                                                                launchUrl(
                                                                  Uri.parse(
                                                                    "https://x.ai/api",
                                                                  ),
                                                                );
                                                                break;
                                                            }
                                                          },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: TextField(
                                                controller: textController,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.aiApiKeyPlaceHolder,
                                                ),
                                                onChanged:
                                                    (value) => tempkey = value,
                                                onSubmitted: (value) {
                                                  Navigator.of(
                                                    context,
                                                  ).pop(value);
                                                },
                                                autocorrect: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(
                                                context,
                                              ).pop(aiApiKey),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.cancel,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(
                                                context,
                                              ).pop(tempkey),
                                          child: Text(
                                            AppLocalizations.of(context)!.ok,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ).then((value) {
                              aiApiKey = value;
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
                                        color:
                                            Theme.of(
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
}
