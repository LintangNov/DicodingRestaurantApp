import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End to end test', (){
    testWidgets('should navigate to Setting Screen and toggle daily reminder switch.', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await app.main();
      await tester.pumpAndSettle();

      final settingsIcon = find.byTooltip('Settings');
      expect(settingsIcon, findsOneWidget);

      await tester.tap(settingsIcon);
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Restaurant Notification'), findsOneWidget);

      final switchWidget = find.byType(Switch).last;
      await tester.tap(switchWidget);
      await tester.pumpAndSettle();
    });
  });
}