import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniassist/screens/profile.screen.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/services/session.service.dart';
import 'package:uniassist/services/timer.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';
import 'package:uniassist/widgets/default.scaffold.dart';
import 'package:uniassist/widgets/session_board.widget.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerService timerService = Provider.of<TimerService>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    SessionService sessionService = locator.get<SessionService>();

    return SafeArea(
      child: DefaultScaffold(
        title: 'TIMER',
        icon: Icon(
          // Fontisto.search,
          // Fontisto.file_1,
          // Feather.user,
          Feather.bar_chart_2,
          // Feather.activity,
          color: kLightGray,
          size: 24,
        ),
        action: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        ),
        body: Stack(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // color: Colors.blue,
                  // padding: EdgeInsets.symmetric(
                  //     // horizontal: kWidth(context) * .06,
                  //     // vertical: kHeight(context) * .06,
                  //     ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Align(
                          child: Icon(
                            Feather.clock,
                            color: kLightGray,
                            size: 24,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      Container(
                        child: Text(
                          '${timerService.currentDuration.inMinutes.toString().padLeft(2, '0')}:${timerService.currentDuration.inSeconds.modPow(1, 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontFamily: 'Teko',
                            fontSize: 144,
                            // height: 1.2,
                            color: kOrange,
                            // height: .95,
                          ),
                        ),
                      ),
                      StreamProvider.value(
                          value: sessionService.streamSessions(user),
                          child: SessionBoard())
                    ],
                  ),
                ),
              ],
            ),
            timerService.isRunning
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () => timerService.stop(context),
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
                              child: Icon(Feather.square),
                            ),
                            Text('STOP'),
                          ],
                        ),
                      ),
                    ),
                  )
                : Offstage(),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => timerService.isRunning
                    ? timerService.pause()
                    : timerService.play(
                        // Duration(minutes: 25),
                        // TODO:You don't wanna waste 25 minutes during demo
                        Duration(minutes: 25),
                        // Duration(seconds: 3),
                        context,
                      ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kHeight(context) * .015,
                    horizontal: kWidth(context) * .06,
                  ),
                  decoration: BoxDecoration(
                    color: timerService.isRunning ? kDarkGray : kOrange,
                    borderRadius: BorderRadius.circular(kWidth(context) * .25),
                  ),
                  child: Container(
                    // padding: EdgeInsets.only(right: 20),
                    //   child: Icon(Feather.play),
                    // ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(timerService.isRunning ? 'PAUSE' : 'PLAY'),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            timerService.isRunning
                                ? Feather.pause
                                : Feather.play,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Feather.play),
        //   onPressed: () => print(user.uid),
        // ),
      ),
    );
  }
}
