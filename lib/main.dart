import 'package:flutter/material.dart';

import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/push_notifications_service.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> sMessengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState(){
    super.initState();

    //Context!
    PushNotificationService.messagesStream.listen((message) { 
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      sMessengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications',
      initialRoute: 'home',
      navigatorKey: navigatorKey,//Navegación
      scaffoldMessengerKey: sMessengerKey,//SnackBar
      routes: {
        'home'    : (_) => HomeScreen(),
        'message' : (_) => MessageScreen()
      }
    );
  }
}