import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/utils/constants.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.symmetric(
                horizontal: kWidth(context) * .12,
                vertical: kHeight(context) * .06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Align(
                      child: Text(
                        'TASK',
                        style: TextStyle(
                          fontFamily: 'Teko',
                          fontSize: 24,
                          // height: .95,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Container(
                    child: Text(
                      '25:00',
                      style: TextStyle(
                        fontFamily: 'Teko',
                        fontSize: 144,
                        color: kOrange,
                        // height: .95,
                      ),
                    ),
                  ),
                  Text(
                    'TODAY: 5/16',
                    style: TextStyle(
                      fontFamily: 'Teko',
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kHeight(context) * .03),
              child: Container(
                color: kLightGray,
                height: kHeight(context) * .30,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Feather.play),
          onPressed: () => print(user.uid),
        ),
      ),
    );
  }
}
