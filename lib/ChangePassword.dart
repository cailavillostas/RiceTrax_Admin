import 'package:flutter/material.dart';
import 'Login.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  void _handleSubmit() {
    final newPassword = _newPassController.text.trim();
    final confirmPassword = _confirmPassController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Error', 'Please fill in all fields.');
    } else if (newPassword.length < 6) {
      _showDialog('Error', 'Password must be at least 6 characters.');
    } else if (newPassword != confirmPassword) {
      _showDialog('Error', 'Passwords do not match.');
    } else {
      _showDialog('Success', 'Password changed successfully!', isSuccess: true);
    }
  }

  void _showDialog(String title, String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              if (isSuccess) {
                Navigator.pop(context); // go back to login
              }
            },
            child: Text(isSuccess ? 'Back to Login' : 'OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.amber[700],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/palay.jpg', fit: BoxFit.cover)),
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.3))),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/rice_logo.jpg', height: 80, width: 80),
                    SizedBox(height: 12),
                    Text('Change Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 24),
                    TextField(
                      controller: _newPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber [700],
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}