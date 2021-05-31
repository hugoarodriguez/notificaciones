import 'package:flutter/material.dart';

import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_creen.dart';
 
void main() => runApp(MyApp());
 
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