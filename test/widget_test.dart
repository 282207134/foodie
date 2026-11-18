import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodieApp());
    await tester.pumpAndSettle();
    // Splash screen should be visible
    expect(find.text('Foodie'), findsOneWidget);
  });
}
