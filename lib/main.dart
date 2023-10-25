import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/constant/value.constant.dart';
import 'package:song_seeker/core/navigation/navigation.constant.dart';
import 'package:song_seeker/core/navigation/navigation.service.dart';
import 'package:song_seeker/ui/home/home.view.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(ProviderScope(child: MyApp()));
  }, (e, s) {
    debugPrint('An error occurred on start-up: ${e.toString()}, $s');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ValueConstant.appName,
      theme: ThemeData.dark(),
      navigatorKey: NavigationService.navigationKey,
      initialRoute: NavConstant.homeRoute,
      onGenerateRoute: NavConstant.generateRoute,
      home: HomeView(),
    );
  }
}
