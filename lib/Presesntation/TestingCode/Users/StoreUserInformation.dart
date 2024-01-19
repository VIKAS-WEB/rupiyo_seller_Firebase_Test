import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/Login.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> registerUser() async {
    final String apiUrl = 'http://192.168.1.41/RUPIYOSELLER_API/InsertUser.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'address': addressController.text,
          'phone_number': phoneNumberController.text,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          print('User registration successful');
          // Show a success dialogue box
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColor.BackgroundColor,
                elevation: 0,
                title: Text('Success'),
                content: Text('User registration successful'),
              );
            },
          );

          // Wait for 2 seconds
          await Future.delayed(Duration(seconds: 3));

          // Navigate to the login screen after 2 seconds
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          // Clear text fields after successful registration
          _clearTextFields();
        } else {
          print('Error: ${result['message']}');
          // Handle the error, show an error message, etc.
        }
      } else {
        print('Failed to register user. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<void> _refreshData() async {
    // Implement your logic to refresh data here (e.g., fetch updated data from the server)
    // For simplicity, we will just simulate a delay for demonstration purposes.
    await Future.delayed(Duration(seconds: 2));
    print('Data refreshed');

    // Clear text fields after pulling to refresh
    _clearTextFields();
  }

  void _clearTextFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    phoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextField(
                controller: addressController,
                obscureText: false,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: phoneNumberController,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'PhoneNumber'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
