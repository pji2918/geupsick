import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'types/geupsickinfoclass.dart';

Future<GeupsickInfo> getMeal(
    DateTime date, String schoolCode, String ministryCode, int idx) async {
  var url = Uri.parse(
      "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=ec86c034134b4479bcbdf413fa3f2288&Type=json&ATPT_OFCDC_SC_CODE=$ministryCode&SD_SCHUL_CODE=$schoolCode&MLSV_YMD=${DateFormat('yyyyMMdd').format(date)}&MMEAL_SC_CODE=${idx + 1}");
  var response = await http.get(url);
  return GeupsickInfo.fromJson(jsonDecode(response.body));
}

Widget printMeal(GeupsickInfo geupsick, DateTime date, String schoolCode,
    String ministryCode, int idx) {
  Column col = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [],
  );

  if (geupsick.mealServiceDietInfo == null) {
    col.children.add(Text(
      "급식이 없습니다.",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ));
    return col;
  } else {
    List<String> meal = [];

    meal = geupsick.mealServiceDietInfo![1].row![0].dDISHNM
        .toString()
        .split("<br/>");
    for (int i = 0; i < meal.length; i++) {
      col.children.add(Text(meal[i]));
      if (i != meal.length - 1) {
        col.children.add(SizedBox(height: 10));
      }
    }

    return col;
  }
}

Future<int> getGScore(int foodIdx, DateTime date, String schoolCode,
    String ministryCode, GeupsickInfo geupsick) async {
  String meal = "";

  if (geupsick.mealServiceDietInfo == null) {
    meal = "";
    return -2;
  }

  meal = geupsick.mealServiceDietInfo![1].row![0].dDISHNM
      .toString()
      .replaceAll("<br/>", "\n");

  if (meal == "") {
    return -2;
  }

  OpenAI.apiKey =
      "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";
  OpenAI.requestsTimeOut = Duration(seconds: 15);
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.system,
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "당신은 객관적으로 급식의 맛을 평가하는 인공지능입니다. 0부터 100까지의 숫자로 평가 점수를 반환하세요. 숫자 이외에 다른 문자를 포함하면 안 됩니다."
            "\n평가는 고기, 디저트, 카레, 튀김 등의 맛있는 음식이 많을 경우 점수가 올라갑니다."
            "\n생선이 포함된 음식이나 해산물, 채소가 많을 경우 점수가 내려갑니다."),
      ]);

  final userMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "다음은 오늘의 학교 급식이야. 평가해 줘: \n$meal"),
      ]);

  final requestMessages = [
    systemMessage,
    userMessage,
  ];

  OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
    model: "gpt-4o-mini",
    messages: requestMessages,
  );

  String responseText =
      completion.choices.first.message.content!.first.text ?? "-1";

  return int.parse(responseText);
}
