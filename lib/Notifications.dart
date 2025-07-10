import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification'), backgroundColor: Colors.green[800]),
      body: Center(child: Text('notification Page')),
    );;
  }
}
