import 'package:flutter/material.dart';
import 'dashboard.dart'; // import your dashboard file

void main() {
  runApp(RiceTraxApp());
}

class RiceTraxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RiceTrax',
      home: Dashboard(),
    );
  }
}