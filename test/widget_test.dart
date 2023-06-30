import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectritsbook_native/main.dart';
import 'package:projectritsbook_native/presentation/pages/exhibition.dart';
import 'package:projectritsbook_native/presentation/pages/landing_page/landing_page.dart';
import 'package:projectritsbook_native/presentation/pages/my_page/my_page.dart';
import 'package:projectritsbook_native/presentation/pages/notification.dart';

void main() {
  testWidgets('RitsBook navigates correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: RitsBook()));

    // Verify that RitsBook starts with LandingPage.
    expect(find.byType(LandingPage), findsOneWidget);

    // Tap the 'お知らせ' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.notifications));
    await tester.pumpAndSettle();

    // Verify that tapping 'お知らせ' icon navigates to NotificationPage.
    expect(find.byType(NotificationPage), findsOneWidget);

    // Tap the '出品' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.camera_alt_outlined));
    await tester.pumpAndSettle();

    // Verify that tapping '出品' icon navigates to ExhibitionPage.
    expect(find.byType(ExhibitionPage), findsOneWidget);

    // Tap the 'マイページ' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that tapping 'マイページ' icon navigates to MyPage.
    expect(find.byType(MyPage), findsOneWidget);
  });
}
