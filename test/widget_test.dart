import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_flutter/app/app.dart';

void main() {
  testWidgets('App bootstraps and shows a loading state initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UniActApp());

    expect(find.text('Loading...'), findsOneWidget);
  });
}
