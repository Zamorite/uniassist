import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/session.dart';
import 'package:uniassist/services/notification.service.dart';
import 'package:uniassist/services/session.service.dart';
import 'package:uniassist/utils/constants.dart';
import 'package:uniassist/utils/service.locator.dart';

class TimerService with ChangeNotifier {
  Duration sessionDuration;
  Duration _currentDuration;
  Timer _timer;

  SessionService sessionService = locator.get<SessionService>();
  NotificationService _notifService = locator.get<NotificationService>();

  get currentDuration => _currentDuration;
  get isRunning => _timer != null;

  TimerService(Duration sessionDuration) {
    _currentDuration = sessionDuration = sessionDuration;
  }

  play(Duration duration, BuildContext context) {
    if (_timer == null) {
      sessionDuration = duration;
    }

    _timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      (timer) {
        _currentDuration -= Duration(seconds: 1);

        if (_currentDuration == Duration.zero) {
          // print('I\'m here');
          stop(context);

          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false, // Android only - API >= 28
            volume: 1, // Android only - API >= 28
            asAlarm: false, // Android only - all APIs
          );

          // _notifService.displayNotif();
        }
        notifyListeners();
      },
    );

    notifyListeners();

    // _timer.
  }

  pause() {
    _timer.cancel();
    _timer = null;
    notifyListeners();
  }

  stop(BuildContext context) {
    pause();
    saveSession(_currentDuration, sessionDuration, context);
    _currentDuration = sessionDuration;
    sessionDuration = null;
    // print('I stopped');

    notifyListeners();

    Flushbar(
      margin: EdgeInsets.symmetric(
          vertical: kHeight(context) * .03, horizontal: kWidth(context) * .03),
      borderRadius: 10,
      message: 'Time\'s up 🎉',
      flushbarStyle: FlushbarStyle.FLOATING,
      // title: 'Task Added',
      duration: Duration(seconds: 3),
      icon: Icon(
        Feather.clock,
        color: kOrange,
      ),
      shouldIconPulse: true,
    )..show(context);
  }

  saveSession(
    Duration currentDuration,
    Duration sessionDuration,
    BuildContext context,
  ) async {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);

    Duration resultant = sessionDuration - currentDuration;
    Session session = Session(
      ownerId: user.uid,
      id: randomAlphaNumeric(28),
      duration: resultant,
    );

    // print(
    //     'Session id: ${session.id}\nSession owner: ${session.ownerId}\nSession duration: ${session.duration}');

    Info info = await sessionService.addSession(session);

    if (!info.success) {
      print('Error: ${info.message}');
    }
  }
}
