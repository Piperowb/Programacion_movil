import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/type_disaster.dart';
import 'screens/alerts.dart';
import 'screens/shelter.dart';
import 'screens/supply_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/alerts': (context) => AlertScreen(),
        '/shelter': (context) => ShelterScreen(),
        '/typeDisaster': (context) => TypeDisasterScreen(),
        '/supplyList': (context) => SupplyListScreen(),
      },
    );
  }
}
