import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:geupsick/l10n/app_localizations.dart';
import 'package:geupsick/utilities/functions.dart';
import 'package:geupsick/utilities/types/geupsickinfoclass.dart';

void main() {
  testWidgets('printMeal shows "food not available" when no meal data', (
    WidgetTester tester,
  ) async {
    final geupsick = GeupsickInfo(); // mealServiceDietInfo == null

    late String expected;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            expected = AppLocalizations.of(context)!.foodNotAvailable;
            return Scaffold(
              body: printMeal(geupsick, DateTime.now(), '', '', 0, context),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(expected), findsOneWidget);
  });

  testWidgets('printMeal splits DDISH_NM on <br/> and shows parts', (
    WidgetTester tester,
  ) async {
    final row = GRow(dDISHNM: 'Rice<br/>Soup');
    final mealInfo = MealServiceDietInfo(row: [row]);
    final geupsick = GeupsickInfo(
      mealServiceDietInfo: [MealServiceDietInfo(), mealInfo],
    );

    // ensure localization loads inside builder

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            // ensure localization is available in this test
            AppLocalizations.of(context);
            return Scaffold(
              body: printMeal(geupsick, DateTime.now(), '', '', 0, context),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Rice'), findsOneWidget);
    expect(find.text('Soup'), findsOneWidget);
  });

  testWidgets('getPadding returns expected values for breakpoints', (
    WidgetTester tester,
  ) async {
    EdgeInsets? result;

    // Large screen (>960)
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(1000, 800)),
        child: Builder(
          builder: (context) {
            result = getPadding(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(result, EdgeInsets.symmetric(horizontal: 20));

    // Medium screen (>640 && <=960)
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(800, 800)),
        child: Builder(
          builder: (context) {
            result = getPadding(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(result, EdgeInsets.fromLTRB(0, 0, 10, 0));

    // Small screen (<=640)
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(400, 800)),
        child: Builder(
          builder: (context) {
            result = getPadding(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(result, EdgeInsets.symmetric(horizontal: 20));
  });
}
