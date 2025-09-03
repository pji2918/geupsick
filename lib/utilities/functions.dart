import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:langchain_google/langchain_google.dart';
import 'package:langchain_anthropic/langchain_anthropic.dart';

import '../settings.dart';
import '../l10n/app_localizations.dart';
import 'types/geupsickinfoclass.dart';

Future<GeupsickInfo?> getMeal(
  DateTime date,
  int idx, {
  String schoolCode = "8851096",
  String ministryCode = "R10",
  String key = "ec86c034134b4479bcbdf413fa3f2288",
}) async {
  var url = Uri.parse(
    "https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=$key&Type=json&ATPT_OFCDC_SC_CODE=$ministryCode&SD_SCHUL_CODE=$schoolCode&MLSV_YMD=${DateFormat('yyyyMMdd').format(date)}&MMEAL_SC_CODE=${idx + 1}",
  );
  var response = await http.get(url);
  return GeupsickInfo.fromJson(jsonDecode(response.body));
}

bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 960.0;
}

bool isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 640.0;
}

Widget printMeal(
  GeupsickInfo geupsick,
  DateTime date,
  String schoolCode,
  String ministryCode,
  int idx,
  BuildContext context,
) {
  Column col = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [],
  );

  if (geupsick.mealServiceDietInfo == null) {
    col.children.add(
      Text(
        AppLocalizations.of(context)!.foodNotAvailable,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
    return col;
  } else {
    List<String> meal = [];

    meal = geupsick.mealServiceDietInfo![1].row![0].dDISHNM.toString().split(
      "<br/>",
    );
    for (int i = 0; i < meal.length; i++) {
      col.children.add(
        Text(
          meal[i],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      );
      if (i != meal.length - 1) {
        col.children.add(SizedBox(height: 10));
      }
    }

    return col;
  }
}

EdgeInsets getPadding(BuildContext context) {
  if (isLargeScreen(context)) {
    return EdgeInsets.symmetric(horizontal: 20);
  } else if (isMediumScreen(context)) {
    return EdgeInsets.fromLTRB(0, 0, 10, 0);
  } else {
    return EdgeInsets.symmetric(horizontal: 20);
  }
}

Future<int> getGScore(GeupsickInfo geupsick) async {
  String meal = "";

  SharedPreferencesAsync pref = SharedPreferencesAsync();

  if (geupsick.mealServiceDietInfo == null) {
    return -2;
  } else {
    meal = geupsick.mealServiceDietInfo![1].row![0].dDISHNM
        .toString()
        .replaceAll("<br/>", "\n");

    final requestMessage = [
      ChatMessage.system(
        "당신은 객관적으로 급식의 맛을 평가하는 인공지능입니다. 0부터 100까지의 정수로 평가 점수를 반환하세요. 숫자 이외에 다른 문자를 포함하면 안 됩니다."
        "\n평가는 고기, 디저트, 카레, 튀김, 볶음밥 등의 저연령층 사이에서 맛있다고 여겨지는 음식이 많을 경우 점수를 높게 평가하세요."
        "\n해산물, 채소, 야채 등의 저연령층 사이에서 맛없다고 여겨지는 음식이 많을 경우 점수를 낮게 평가하세요.",
      ),
      ChatMessage.humanText("다음은 오늘의 학교 급식이야. 평가해 줘:\n$meal"),
    ];

    if (await pref.getBool("useGScore") == false ||
        await pref.getString("aiApiKey") == "" ||
        await pref.getString("aiApiKey") == null) {
      return -2;
    } else {
      switch (ModelSelection.values[await pref.getInt("modelSelection") ?? 0]) {
        case ModelSelection.openAI:
          {
            ChatOpenAI llm = ChatOpenAI(
              apiKey: (await pref.getString("aiApiKey")),
              defaultOptions: ChatOpenAIOptions(model: "gpt-5-nano"),
            );
            ChatResult response = await llm.invoke(
              PromptValue.chat(requestMessage),
            );
            return int.parse(response.outputAsString);
          }
        case ModelSelection.google:
          {
            ChatGoogleGenerativeAI llm = ChatGoogleGenerativeAI(
              apiKey: (await pref.getString("aiApiKey")),
              defaultOptions: ChatGoogleGenerativeAIOptions(
                model: "models/gemini-2.5-flash-lite",
              ),
            );
            ChatResult response = await llm.invoke(
              PromptValue.chat(requestMessage),
            );
            return int.parse(response.outputAsString);
          }
        case ModelSelection.anthropic:
          {
            ChatAnthropic llm = ChatAnthropic(
              apiKey: (await pref.getString("aiApiKey")),
              defaultOptions: ChatAnthropicOptions(model: "claude-sonnet-4-0"),
            );
            ChatResult response = await llm.invoke(
              PromptValue.chat(requestMessage),
            );
            return int.parse(response.outputAsString);
          }
        case ModelSelection.xAI:
          {
            ChatOpenAI llm = ChatOpenAI(
              apiKey: (await pref.getString("aiApiKey")),
              defaultOptions: ChatOpenAIOptions(model: "grok-3-mini"),
              baseUrl: "https://api.x.ai/v1",
            );
            ChatResult response = await llm.invoke(
              PromptValue.chat(requestMessage),
            );
            return int.parse(response.outputAsString);
          }
      }
    }
  }
}
