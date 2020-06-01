import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/utils/service.locator.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var authService = locator.get<AuthService>();

    bool loggedIn = user != null;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              loggedIn
                  ? '😎 Logged in as ${user.displayName}'
                  : '⚠ Not Logged in',
            ),
            MaterialButton(
              child: Text(
                loggedIn ? 'Log out' : 'Log in',
              ),
              onPressed:
                  loggedIn ? authService.signout() : authService.googleSignIn(),
            ),
          ],
        ),
      ),
    );
  }
}
