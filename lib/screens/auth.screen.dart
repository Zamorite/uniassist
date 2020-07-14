import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/screens/main.screen.dart';
import 'package:uniassist/screens/timer.screen.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var authService = locator.get<AuthService>();

    // bool loggedIn = user != null;

    // if (loggedIn) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => MainScreen(),
    //     ),
    //   );
    // }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: kHeight(context) * .06,
            horizontal: kWidth(context) * .06,
          ),
          child: Stack(
            children: <Widget>[
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'UNI',
                    style: kH1.copyWith(fontSize: 72),
                    children: [
                      TextSpan(
                        text: 'ASSIST',
                        style: kH1.copyWith(fontSize: 72, color: kOrange),
                      ),
                    ],
                  ),
                  // style: kH1.copyWith(fontSize: 72),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Flushbar(
                      margin: EdgeInsets.symmetric(
                          vertical: kHeight(context) * .03,
                          horizontal: kWidth(context) * .03),
                      borderRadius: 10,
                      message: 'Setting your account up 😉',
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Connecting to Google',
                      duration: Duration(seconds: 5),
                      icon: Icon(
                        // Feather.co
                        Entypo.power_plug,
                        color: kOrange,
                      ),
                      shouldIconPulse: true,
                    )..show(context);

                    authService.googleSignIn().then(
                      (user) {
                        if (user == null) {
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: kHeight(context) * .015,
                      horizontal: kWidth(context) * .06,
                    ),
                    decoration: BoxDecoration(
                      color: kDarkGray,
                      borderRadius:
                          BorderRadius.circular(kWidth(context) * .25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Fontisto.google),
                        ),
                        Text('Continue with Google'),
                      ],
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: MaterialButton(
              //     padding: EdgeInsets.symmetric(
              //       vertical: kHeight(context) * .03,
              //       horizontal: kWidth(context) * .06,
              //     ),
              //     color: kDarkGray,
              //     onPressed:
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: <Widget>[
              //         Icon(Fontisto.google),
              //         Text(
              //           'Continue with Google',
              //           style: TextStyle(
              //             fontSize: 18,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
