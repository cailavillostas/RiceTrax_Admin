import 'package:flutter/material.dart';
import 'dashboard.dart'; // Optional: Only if you're using it later
import 'Table.dart';     // Make sure this file contains RiceStock class

void main() {
  runApp(RiceTraxApp());
}

class RiceTraxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RiceTrax',
      home: RiceStock(), // 👈 Set this as the home screen
    );
  }
}
