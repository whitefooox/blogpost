import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class AppLock extends StatefulWidget {
  final Widget child;
  final Duration backgroundLockLatency;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool isEnabled;
  const AppLock({
    super.key, 
    required this.child, 
    required this.navigatorKey,
    this.isEnabled = true,
    this.backgroundLockLatency = const Duration(seconds: 0)
  });

  @override
  State<AppLock> createState() => _AppLockState();
}

class _AppLockState extends State<AppLock> {

  late final AppLifecycleListener _listener;
  Timer? _backgroundLockLatencyTimer;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onPause: (){
        if (!widget.isEnabled) {
          return;
        }
        if(!_isLocked){
          _backgroundLockLatencyTimer = Timer(widget.backgroundLockLatency, () => showLockScreen());
        }
      },
      onResume: () => log("resume"),
    );
  }

  Future<void> showLockScreen() async {
    _isLocked = true;
    log("lock screen");
    //final currentRoute = ModalRoute.of(context)!.settings.name!;
    widget.navigatorKey.currentState!.pushReplacementNamed("/enter_lock");
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}