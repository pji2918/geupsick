import 'dart:convert';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../l10n/app_localizations.dart';
import 'types/schoolinfoclass.dart';

class SchoolChanger extends StatefulWidget {
  const SchoolChanger({
    super.key,
    required this.schoolCode,
    required this.ministryCode,
  });

  final String schoolCode;
  final String ministryCode;

  @override
  State<SchoolChanger> createState() => _SchoolChangerState();
}

class _SchoolChangerState extends State<SchoolChanger> {
  String schoolCode = "";
  String ministryCode = "B10";
  String schoolName = "";

  List<DropdownMenuEntry<String>> ministryList = [];

  @override
  void initState() {
    super.initState();
    schoolCode = widget.schoolCode;
    ministryCode = widget.ministryCode;
  }

  Future<Widget> fetchSchools() async {
    await dotenv.load(fileName: ".env");

    var response = await http.get(
      Uri.parse(
        "https://open.neis.go.kr/hub/schoolInfo?KEY=${dotenv.env["KEY"]}&Type=json&ATPT_OFCDC_SC_CODE=$ministryCode&SCHUL_NM=$schoolName&pSize=500",
      ),
    );
    SchoolData schoolData = SchoolData.fromJson(jsonDecode(response.body));

    if (schoolData.schoolInfo![1].row == null && mounted) {
      return Center(child: Text(AppLocalizations.of(context)!.noSearchResults));
    } else {
      return Card.outlined(
        child: ListView.builder(
          itemCount: schoolData.schoolInfo![1].row!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(schoolData.schoolInfo![1].row![index].sCHULNM!),
              subtitle: Text(schoolData.schoolInfo![1].row![index].oRGRDNMA!),
              onTap: () {
                setState(
                  () => schoolCode =
                      schoolData.schoolInfo![1].row![index].sDSCHULCODE!,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.schoolChanged),
                  ),
                );
                // pass values to parent widget
                Navigator.pop(context, [schoolCode, ministryCode]);
              },
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ministryList = [
      DropdownMenuEntry(
        value: "B10",
        label: AppLocalizations.of(context)!.ministry_Seoul,
      ),
      DropdownMenuEntry(
        value: "C10",
        label: AppLocalizations.of(context)!.ministry_Busan,
      ),
      DropdownMenuEntry(
        value: "D10",
        label: AppLocalizations.of(context)!.ministry_Daegu,
      ),
      DropdownMenuEntry(
        value: "E10",
        label: AppLocalizations.of(context)!.ministry_Incheon,
      ),
      DropdownMenuEntry(
        value: "F10",
        label: AppLocalizations.of(context)!.ministry_Gwangju,
      ),
      DropdownMenuEntry(
        value: "G10",
        label: AppLocalizations.of(context)!.ministry_Daejeon,
      ),
      DropdownMenuEntry(
        value: "H10",
        label: AppLocalizations.of(context)!.ministry_Ulsan,
      ),
      DropdownMenuEntry(
        value: "I10",
        label: AppLocalizations.of(context)!.ministry_Sejong,
      ),
      DropdownMenuEntry(
        value: "J10",
        label: AppLocalizations.of(context)!.ministry_Gyeonggi,
      ),
      DropdownMenuEntry(
        value: "K10",
        label: AppLocalizations.of(context)!.ministry_Gangwon,
      ),
      DropdownMenuEntry(
        value: "M10",
        label: AppLocalizations.of(context)!.ministry_Chungbuk,
      ),
      DropdownMenuEntry(
        value: "N10",
        label: AppLocalizations.of(context)!.ministry_Chungnam,
      ),
      DropdownMenuEntry(
        value: "P10",
        label: AppLocalizations.of(context)!.ministry_Jeonbuk,
      ),
      DropdownMenuEntry(
        value: "Q10",
        label: AppLocalizations.of(context)!.ministry_Jeonnam,
      ),
      DropdownMenuEntry(
        value: "R10",
        label: AppLocalizations.of(context)!.ministry_Gyeongbuk,
      ),
      DropdownMenuEntry(
        value: "S10",
        label: AppLocalizations.of(context)!.ministry_Gyeongnam,
      ),
      DropdownMenuEntry(
        value: "T10",
        label: AppLocalizations.of(context)!.ministry_Jeju,
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.schoolChanger),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: DropdownMenu<String>(
                    menuHeight:
                        300, // caused by https://github.com/flutter/flutter/issues/123395. will be removed when it resolved.
                    dropdownMenuEntries: ministryList,
                    requestFocusOnTap: false,
                    label: Text(
                      AppLocalizations.of(context)!.ministrySelection,
                    ),
                    initialSelection: ministryCode,
                    onSelected: (selected) {
                      setState(() => ministryCode = selected!);
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.schoolSearchPlaceholder,
                    ),
                    onChanged: (value) {
                      setState(() => schoolName = value);
                    },
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 5,
                  child: FutureBuilder(
                    future: fetchSchools(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Card.outlined(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Card.outlined(
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!.searchNotAccurate,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return SizedBox.shrink();
                      } else {
                        return snapshot.data!;
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
