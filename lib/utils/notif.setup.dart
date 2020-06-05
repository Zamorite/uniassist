import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uniassist/screens/dashboard.dart';
import 'package:uniassist/utils/service.locator.dart';

initializeNotif() async {
  FlutterLocalNotificationsPlugin notifPlugin = locator.get<FlutterLocalNotificationsPlugin>();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await notifPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
}

Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload,) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      // context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => SecondScreen(payload),
                      builder: (context) => Dashboard(),
                    ),
                  );
                },
              )
            ],
          ),
    );
  }




Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    // );
}