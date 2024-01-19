import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/UD.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/UserDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _savePhoneNumber(String phoneNumber) async {
    await _prefs.setString('phone_number', phoneNumber);
  }

  Future<String?> _getPhoneNumber() async {
    return _prefs.getString('phone_number');
  }

  Future<void> _loadUserData() async {
    try {
      String? storedPhoneNumber = await _getPhoneNumber();

      if (storedPhoneNumber != null) {
        final response = await http.get(
          Uri.parse(
              'http://192.168.1.41/RUPIYOSELLER_API/getUser.php?phone_number=$storedPhoneNumber'),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(response.body);
          print('User details: $userData');
          _navigateToUserDashboard(userData);
        } else {
          print('Error loading user data: ${response.statusCode}');
        }
      } else {
        print('No stored phone number found.');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> loginUser() async {
    final String apiUrl = 'http://192.168.1.41/RUPIYOSELLER_API/Login.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': phoneNumberController.text,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          print('Login successful');

          // Save the phone number to SharedPreferences
          await _savePhoneNumber(phoneNumberController.text);

          // Show Lottie animation in a dialog box
          _showLottieDialog();

          // Navigate to dashboard after a 2-second delay
          Future.delayed(Duration(seconds: 2), () {
            _loadUserData();
          });

          //Load user data after successful login
          ;
        } else {
          print('Error: ${result['message']}');
          // Handle the error, show an error message, etc.
        }
      } else {
        print('Failed to login. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  Future<void> _navigateToUserDashboard(Map<String, dynamic> userData) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDashboard(userData: userData),
      ),
    );
  }

  void _showLottieDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'Assets/LottieAssets/Success.json', // Replace with your Lottie animation file path
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16),
              Text(
                'Login Successful',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
