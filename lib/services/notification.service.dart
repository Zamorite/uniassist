import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uniassist/utils/service.locator.dart';

class NotificationService {

  FlutterLocalNotificationsPlugin notifPlugin = locator.get<FlutterLocalNotificationsPlugin>();

  displayNotif() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifPlugin.show(
    0, 'plain title', 'plain body', platformChannelSpecifics,
    payload: 'item x');
  }
  
  scheduleNotif() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your other channel id',
            'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifPlugin.schedule(
    0,
    'scheduled title',
    'scheduled body',
    scheduledNotificationDateTime,
    platformChannelSpecifics);
  }

  cancelNotif(int id) async {
    await notifPlugin.cancel(id);
  }

  cancelNotifs() async {
    await notifPlugin.cancelAll();
  }


}