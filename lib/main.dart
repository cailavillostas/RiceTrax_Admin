import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Inventory.dart';
import 'RiceStock.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'ChangePassword.dart';

void main() {
  runApp(RiceTraxApp());
}

class RiceTraxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiceTrax',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/change_password': (context) => ChangePasswordScreen(),
        '/dashboard': (context) => Dashboard(),
        '/inventory': (context) => Inventory(),
        '/rice_stock': (context) => RiceStock(),
      },
    );
  }
}
