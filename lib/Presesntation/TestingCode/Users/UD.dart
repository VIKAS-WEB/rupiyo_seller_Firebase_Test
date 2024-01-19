import 'package:flutter/material.dart';

class UD extends StatelessWidget {
  final Map<String, dynamic> userData;

  UD({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${userData['username']}!'),
            SizedBox(
              height: 39,
            ),
            Text('Email - ${userData['email']}!'),
            SizedBox(
              height: 39,
            ),
            Text('Address - ${userData['address']}!'),

            // Display other user-related information
            // Add other widgets and functionality for the user dashboard
          ],
        ),
      ),
    );
  }
}
