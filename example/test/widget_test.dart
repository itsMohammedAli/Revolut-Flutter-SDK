import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolut_sdk_bridge_example/main.dart';

void main() {
  testWidgets('Demo opens without merchant credentials', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Revolut Pay SDK Demo'), findsOneWidget);
    expect(find.text('SDK Not Initialized'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Initialize SDK'), findsOneWidget);
  });
}
