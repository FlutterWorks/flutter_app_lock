import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> setAppLifecycleToHidden(WidgetTester widgetTester) async {
  widgetTester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);

  await widgetTester.pumpAndSettle();
}

Future<void> setAppLifecycleToInactive(WidgetTester widgetTester) async {
  widgetTester.binding
      .handleAppLifecycleStateChanged(AppLifecycleState.inactive);

  await widgetTester.pumpAndSettle();
}

Future<void> setAppLifecycleToResumed(WidgetTester widgetTester) async {
  widgetTester.binding
      .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

  await widgetTester.pumpAndSettle();
}

void enableAppLockAfterLaunch(WidgetTester widgetTester) {
  widgetTester.state<AppLockState>(find.byType(AppLock)).enable();
}

void main() {
  group('Given an AppLock widget with inactive behaviour set to always show',
      () {
    group('When it is enabled', () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group('When it is enabled and the app transitions from inactive to resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app transitions from inactive to hidden for longer than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app transitions from inactive to hidden for less than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 2),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the background lock latency is changed at runtime and the app transitions from inactive to hidden for longer than the new lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      final GlobalKey<AppLockState> appLockKey = GlobalKey();

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            key: appLockKey,
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: Duration.zero,
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets(
          'The lock screen should be shown if inactive for longer than the new background lock latency',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        appLockKey.currentState!
            .setBackgroundLockLatency(const Duration(seconds: 5));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 6));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the background lock latency is changed at runtime and the app transitions from inactive to hidden for less than the new lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      final GlobalKey<AppLockState> appLockKey = GlobalKey();

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            key: appLockKey,
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: Duration.zero,
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets(
          'The lock screen should not be shown if inactive for less than the new background lock latency',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        appLockKey.currentState!
            .setBackgroundLockLatency(const Duration(seconds: 5));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });
    });

    group('When it is disabled', () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsOneWidget);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsOneWidget);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to hidden for longer than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to hidden for less than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.alwaysShow,
            initialBackgroundLockLatency: const Duration(seconds: 2),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });
  });

  group(
      'Given an AppLock widget with inactive behaviour set to show when enabled',
      () {
    group('When it is enabled', () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group('When it is enabled and the app transitions from inactive to resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app transitions from inactive to hidden for longer than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is enabled and the app transitions from inactive to hidden for less than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 2),
            initiallyEnabled: true,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the background lock latency is changed at runtime and the app transitions from inactive to hidden for longer than the new lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      final GlobalKey<AppLockState> appLockKey = GlobalKey();

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            key: appLockKey,
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: Duration.zero,
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets(
          'The lock screen should be shown if inactive for longer than the new background lock latency',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        appLockKey.currentState!
            .setBackgroundLockLatency(const Duration(seconds: 5));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 6));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the background lock latency is changed at runtime and the app transitions from inactive to hidden for less than the new lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      final GlobalKey<AppLockState> appLockKey = GlobalKey();

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            key: appLockKey,
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: Duration.zero,
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets(
          'The lock screen should not be shown if inactive for less than the new background lock latency',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        appLockKey.currentState!
            .setBackgroundLockLatency(const Duration(seconds: 5));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });
    });

    group('When it is disabled', () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        await widgetTester.pumpWidget(sut);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app becomes inactive without an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app becomes inactive with an inactive builder set',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsOneWidget);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to hidden for longer than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 1),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsOneWidget);
      });

      testWidgets('The unlocked app should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsNothing);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 2));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });

    group(
        'When it is disabled and then enabled at runtime and the app transitions from inactive to hidden for less than the lock duration and back to inactive and resumed',
        () {
      late Widget sut;

      setUp(() {
        sut = MaterialApp(
          builder: (context, child) => AppLock(
            inactiveBehavior: InactiveBehavior.showWhenEnabled,
            initialBackgroundLockLatency: const Duration(seconds: 2),
            initiallyEnabled: false,
            builder: (context, launchArg) => KeyedSubtree(
              key: const Key('Unlocked'),
              child: child!,
            ),
            lockScreenBuilder: (context) => const Scaffold(
              key: Key('LockScreen'),
            ),
            inactiveBuilder: (context) => const Scaffold(
              key: Key('InactiveScreen'),
            ),
          ),
          home: const Scaffold(),
        );
      });

      testWidgets('The lock screen should not be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('LockScreen')), findsNothing);
      });

      testWidgets('The unlocked app should be shown', (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('Unlocked')), findsOneWidget);
      });

      testWidgets('The inactive screen should not be shown',
          (widgetTester) async {
        addTearDown(() {
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        });

        await widgetTester.pumpWidget(sut);

        enableAppLockAfterLaunch(widgetTester);

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToHidden(widgetTester);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        await setAppLifecycleToInactive(widgetTester);
        await setAppLifecycleToResumed(widgetTester);

        expect(find.byKey(const Key('InactiveScreen')), findsNothing);
      });
    });
  });
}
