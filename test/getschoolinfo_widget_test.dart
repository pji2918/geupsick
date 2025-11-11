import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geupsick/l10n/app_localizations.dart';
import 'package:geupsick/utilities/getschoolinfo.dart';

void main() {
  testWidgets('SchoolChanger shows TextField and uses injected fetchSchools', (
    WidgetTester tester,
  ) async {
    // stub that avoids network and returns a simple widget
    Future<Widget> stubFetchSchools() async {
      return Card(child: Center(child: Text('stub-result')));
    }

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ko')],
        home: SchoolChanger(
          schoolCode: '',
          ministryCode: 'B10',
          fetchSchools: stubFetchSchools,
        ),
      ),
    );

    // allow async tasks to complete
    await tester.pumpAndSettle();

    // verify TextField(s) present (DropdownMenu may include a TextField internally)
    expect(find.byType(TextField), findsWidgets);

    // verify the stubbed fetch result is shown
    expect(find.text('stub-result'), findsOneWidget);
  });
}
