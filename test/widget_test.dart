import 'package:flutter_test/flutter_test.dart';
import 'package:space_news_aggregator/main.dart';

void main() {
  testWidgets('Basic widget test with permission granted',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(permissionGranted: true));

    // Verify that the initial page is shown based on permissionGranted value
    expect(find.text('Welcome to Space News Aggregator!'), findsOneWidget);
    // Add more tests to verify other widgets and functionality if needed
  });

  testWidgets('Basic widget test with permission denied',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(permissionGranted: false));

    // Verify that the PermissionDeniedPage is shown
    expect(
        find.text(
            'Storage permission is required to use this app. Please enable it in settings.'),
        findsOneWidget);
    // Add more tests to verify other widgets and functionality if needed
  });
}

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:space_news_aggregator/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
