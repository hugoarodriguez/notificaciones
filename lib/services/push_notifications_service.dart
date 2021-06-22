import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//SHA1: 73:F1:68:E6:D8:62:E0:F2:82:B5:DF:0E:5A:67:D1:DC:B7:1E:3B:C3

class PushNotificationService{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onBackgroundHandler: ${message.messageId}');
    print(message.data);
    _messageStream.add( message.data['product'] ?? 'No Data' );
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessageHandler: ${message.messageId}');
    print(message.data);
    _messageStream.add( message.data['product'] ?? 'No Data' );

    myLocalNotification(message);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp: ${message.messageId}');
    print(message.data);
    _messageStream.add( message.data['product'] ?? 'No Data' );
  }

  static Future initializeApp() async {

    //Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    
    //Local Notifications
  }

  static closeStreams(){
    _messageStream.close();
  }

  //Crear LocalNotification
  static void myLocalNotification(RemoteMessage message) async {

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);

    RemoteNotification? notification = message.notification;
    String iconName = AndroidInitializationSettings('@mipmap/ic_launcher').defaultIcon.toString();

    // Si `onMessage` es activado con una notificación, construímos nuestra propia
    // notificación local para mostrar a los usuarios, usando el canal creado.
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: iconName
          ),
        )
      );
    }

  }
}