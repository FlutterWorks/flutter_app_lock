import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';

import 'app/app.dart';

void main({
  @visibleForTesting bool initiallyEnabled = false,
  @visibleForTesting
  Duration initialBackgroundLockLatency = const Duration(seconds: 30),
  @visibleForTesting
  InactiveBehaviour inactiveBehaviour = InactiveBehaviour.showWhenEnabled,
}) {
  runApp(MyApp(
    initiallyEnabled: initiallyEnabled,
    initialBackgroundLockLatency: initialBackgroundLockLatency,
    inactiveBehaviour: inactiveBehaviour,
  ));
}
