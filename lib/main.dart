import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LOGIN FORM')),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email
            Text("Email:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter email',
              ),
            ),
            SizedBox(height: 20),

            // Password
            Text("Password:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter password',
              ),
            ),
            SizedBox(height: 30),

            // Login Button
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;
                print("Logging in: $email / $password");
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}