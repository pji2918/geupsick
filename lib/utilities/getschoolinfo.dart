import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neis_school_client/neis_school_client.dart';

import '../l10n/app_localizations.dart';

class SchoolChanger extends StatefulWidget {
  const SchoolChanger({
    super.key,
    required this.schoolCode,
    required this.ministryCode,
    this.fetchSchools,
  });

  final String schoolCode;
  final String ministryCode;
  // optional override for testing to avoid network calls
  final Future<Widget> Function()? fetchSchools;

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
  }

  // allow tests to override the network call by providing
  // a `fetchSchools` callback on the widget. This helper
  // will prefer the injected callback when present.
  Future<Widget> _invokeFetchSchools() async {
    if (widget.fetchSchools != null) return widget.fetchSchools!();
    return fetchSchools();
  }

  Future<Widget> fetchSchools() async {
    await dotenv.load(fileName: ".env");

    // var response = await http.get(
    //   Uri.parse(
    //     "https://open.neis.go.kr/hub/schoolInfo?KEY=${dotenv.env["KEY"]}&Type=json&ATPT_OFCDC_SC_CODE=$ministryCode&SCHUL_NM=$schoolName",
    //   ),
    // );
    // SchoolData schoolData = SchoolData.fromJson(jsonDecode(response.body));

    final api = NeisSchoolClient().getDefaultApi();
    var response = await api.hubSchoolInfoGet(
      key: dotenv.env["KEY"]!,
      type: "json",
    );

    if (response.data?.schoolInfo![1].SCHUL_NM == null && mounted) {
      return Center(child: Text(AppLocalizations.of(context)!.noSearchResults));
    } else {
      return Card.outlined(
        child: ListView.builder(
          itemCount: response.data?.schoolInfo!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(response.data!.schoolInfo![index].SCHUL_NM!),
              subtitle: Text(response.data!.schoolInfo![index].ORG_RDNMA!),
              onTap: () {
                setState(
                  () => schoolCode =
                      response.data!.schoolInfo![index].SD_SCHUL_CODE!,
                );
                // pass values to parent widget
                Navigator.pop(context, [schoolCode, ministryCode]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.schoolChanged),
                  ),
                );
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
                    future: _invokeFetchSchools(),
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
