import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/screens/auth.screen.dart';
import 'package:uniassist/screens/main.screen.dart';
import 'package:uniassist/screens/tasks.screen.dart';
import 'package:uniassist/services/timer.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/utils/theme.dart';

GetIt getIt = GetIt.instance;

//***** Entry point of Flutter Application
void main() {
  setupLocator(); // Handle dependency injection
  runApp(UniAssist());
}

class UniAssist extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(
            kDarkTheme,
          ),
        ),
        ChangeNotifierProvider<TimerService>(
          create: (_) => TimerService(
            // TODO:You don't wanna waste 25 minutes during demo
            Duration(minutes: 25),
            // Duration(seconds: 3),
            // Duration(minutes: 25),
          ),
        ),
      ],
      child: ThemedMaterialApp(),
    );
  }
}

class ThemedMaterialApp extends StatelessWidget {
  const ThemedMaterialApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var user = Provider.of<FirebaseUser>(context);

    return MaterialApp(
      title: 'UniAssist',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: theme.getTheme(),
      // home: Dashboard(),
      // home: SandBox(),
      // home: TasksScreen(),
      // home: MainScreen(),
      home: user == null ? AuthScreen() : MainScreen(),
    );
  }
}

// TODO: Add the following to proguard
// -keep class com.dexterous.** { *; }
