import 'dart:developer';

import 'package:blogpost/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLifecycleListener _listener;
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _onPaused();
    }
  }

  void _onDetached() => log('detached');

  void _onResumed() => log('resumed');

  void _onInactive() => log('inactive');

  void _onHidden() => log('hidden');

  void _onPaused() => log('paused');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _appRouter.initialRoute,
      onGenerateRoute: _appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false
    );
  }
}