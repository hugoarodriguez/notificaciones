import 'package:flutter/material.dart';

import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_creen.dart';
import 'package:notificaciones/services/push_notifications_service.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications',
      initialRoute: 'home',
      routes: {
        'home'    : (_) => HomeScreen(),
        'message' : (_) => MessageScreen()
      }
    );
  }
}