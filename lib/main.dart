import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/screens/dashboard.dart';
import 'package:uniassist/utils/service.locator.dart';

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
            value: FirebaseAuth.instance.onAuthStateChanged)
      ],
      child: MaterialApp(
        title: 'UniAssist',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Dashboard(),
      ),
    );
  }
}
