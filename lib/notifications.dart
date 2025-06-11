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

   /* await firebaseMessaging.requestPermission();
    final notificationToken=await firebaseMessaging.getToken();
    print("Notification Token= $notificationToken");
    FirebaseMessaging.onBackgroundMessage(handleNotification);*/



}

Future<void>handleNotification(RemoteMessage message)async{

  print("title : ${message.notification?.title}");
  print("title : ${message.notification?.body}");

}