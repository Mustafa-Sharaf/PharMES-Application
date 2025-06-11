
import 'package:firebase_messaging/firebase_messaging.dart';


class Notifications {
  final firebaseMessaging=FirebaseMessaging.instance;


    Future<void> initNotifications() async {
      try {
        await FirebaseMessaging.instance.requestPermission();
        final token = await FirebaseMessaging.instance.getToken();
        print("Notification Token============================= $token");
        FirebaseMessaging.onBackgroundMessage(handleNotification);
      } catch (e) {
        print("❌ Failed to get FCM token: $e");
      }
    }


/*
    await firebaseMessaging.requestPermission();
    final notificationToken=await firebaseMessaging.getToken();
    print("Notification Token= $notificationToken");
    FirebaseMessaging.onBackgroundMessage(handleNotification);
*/




}

Future<void>handleNotification(RemoteMessage message)async{

  print("title : ${message.notification?.title}");
  print("title : ${message.notification?.body}");

}

/*

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);


    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print('TokenFirebaseNotifications--------: $token');
        handleBackgroundNotification();
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('تم استلام إشعار جديد: ${message.notification?.title}');
        _showNotification(message);
      });
    } else {
      print('لم يتم منح الإذن');
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    //Get.find<UserRoleController>().addMessage(message.notification?.body ?? "No Body");
  }


  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
*/
