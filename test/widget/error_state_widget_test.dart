import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screen/widget/error_state_widget.dart';

void main() {
  group('ErrorStateWidget Test', () {
    testWidgets(
      'should display error message and icon when ErrorStateWidget is rendered.',
      (WidgetTester tester) async {
        const errorMessage = "No internet connection";

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: ErrorStateWidget(message: errorMessage)),
          ),
        );

        expect(find.text("Oops!"), findsOneWidget);
        expect(find.text(errorMessage), findsOneWidget);
        expect(find.byType(Icon), findsOneWidget);
      },
    );
  });
}
