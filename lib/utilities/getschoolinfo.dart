import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'types/schoolinfoclass.dart';

class SchoolChanger extends StatefulWidget {
  const SchoolChanger(
      {super.key, required this.schoolCode, required this.ministryCode});

  final String schoolCode;
  final String ministryCode;

  @override
  State<SchoolChanger> createState() => _SchoolChangerState();
}

class _SchoolChangerState extends State<SchoolChanger> {
  final String apiKey = "ec86c034134b4479bcbdf413fa3f2288";
  String schoolCode = "";
  String ministryCode = "B10";
  String schoolName = "";

  List<DropdownMenuEntry<String>> ministryList = [
    DropdownMenuEntry(value: "B10", label: "서울특별시교육청"),
    DropdownMenuEntry(value: "C10", label: "부산광역시교육청"),
    DropdownMenuEntry(value: "D10", label: "대구광역시교육청"),
    DropdownMenuEntry(value: "E10", label: "인천광역시교육청"),
    DropdownMenuEntry(value: "F10", label: "광주광역시교육청"),
    DropdownMenuEntry(value: "G10", label: "대전광역시교육청"),
    DropdownMenuEntry(value: "H10", label: "울산광역시교육청"),
    DropdownMenuEntry(value: "I10", label: "세종특별자치시교육청"),
    DropdownMenuEntry(value: "J10", label: "경기도교육청"),
    DropdownMenuEntry(value: "K10", label: "강원특별자치도교육청"),
    DropdownMenuEntry(value: "M10", label: "충청북도교육청"),
    DropdownMenuEntry(value: "N10", label: "충청남도교육청"),
    DropdownMenuEntry(value: "P10", label: "전북특별자치도교육청"),
    DropdownMenuEntry(value: "Q10", label: "전라남도교육청"),
    DropdownMenuEntry(value: "R10", label: "경상북도교육청"),
    DropdownMenuEntry(value: "S10", label: "경상남도교육청"),
    DropdownMenuEntry(value: "T10", label: "제주특별자치도교육청"),
    DropdownMenuEntry(value: "V10", label: "재외한국학교교육청"),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<Widget> fetchSchools() async {
    var response = await http.get(Uri.parse(
        "https://open.neis.go.kr/hub/schoolInfo?KEY=$apiKey&Type=json&ATPT_OFCDC_SC_CODE=$ministryCode&SCHUL_NM=$schoolName"));
    SchoolData schoolData = SchoolData.fromJson(jsonDecode(response.body));
    if (schoolData.schoolInfo![1].row == null) {
      return Center(child: Text("검색 결과가 없습니다."));
    } else {
      return SizedBox(
        height: min(
          schoolData.schoolInfo![1].row!.length * 70.0,
          mounted ? MediaQuery.of(context).size.height * 0.6 : 100,
        ),
        child: Card.outlined(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: schoolData.schoolInfo![1].row!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(schoolData.schoolInfo![1].row![index].sCHULNM!),
                subtitle: Text(schoolData.schoolInfo![1].row![index].oRGRDNMA!),
                onTap: () {
                  setState(() {
                    schoolCode =
                        schoolData.schoolInfo![1].row![index].sDSCHULCODE!;
                  });
                  // pass values to parent widget
                  Navigator.pop(context, [schoolCode, ministryCode]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("학교가 변경되었습니다."),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("학교 변경"),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Builder(
        builder: (context) {
          return Align(
            alignment: Alignment.topCenter,
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu<String>(
                      dropdownMenuEntries: ministryList,
                      requestFocusOnTap: false,
                      label: Text("시도교육청 선택"),
                      initialSelection: ministryCode,
                      onSelected: (String? selected) {
                        setState(() {
                          ministryCode = selected!;
                        });
                      },
                    ),
                    TextField(
                      autocorrect: false,
                      autofocus: true,
                      decoration: InputDecoration(hintText: "학교 이름을 입력하여 검색"),
                      onChanged: (value) {
                        setState(() {
                          schoolName = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    FutureBuilder(
                      future: fetchSchools(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: 100,
                            child: Card.outlined(
                                child:
                                    Center(child: CircularProgressIndicator())),
                          );
                        } else if (snapshot.hasError) {
                          return SizedBox(
                            height: 100,
                            child: Card.outlined(
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "결과가 없습니다.\n더 자세히 입력해 보시는 건 어떨까요?",
                                  overflow: TextOverflow.fade,
                                ),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
