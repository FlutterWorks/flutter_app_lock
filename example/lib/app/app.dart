import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';

import '../screens/lock_screen.dart';
import '../screens/my_home_page.dart';

class MyApp extends StatelessWidget {
  final bool enabled;
  final Duration backgroundLockLatency;

  const MyApp({
    Key? key,
    this.enabled = false,
    this.backgroundLockLatency = const Duration(seconds: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      builder: (context, child) => AppLock(
        builder: (context, arg) => child!,
        lockScreen: const LockScreen(
          key: Key('LockScreen'),
        ),
        enabled: enabled,
        backgroundLockLatency: backgroundLockLatency,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}
