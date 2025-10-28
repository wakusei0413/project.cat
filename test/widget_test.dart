import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:project_cat/app.dart';

void main() {
  testWidgets('App launches with calculator placeholder', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.text('Calculator'), findsOneWidget);
    expect(find.text('Project Cat Calculator'), findsOneWidget);
    expect(find.text('Coming Soon'), findsOneWidget);
    expect(find.byIcon(Icons.calculate), findsOneWidget);
  });
}
