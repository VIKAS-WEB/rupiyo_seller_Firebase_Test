import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final _phoneNumberController = StreamController<String>();
  final _userDataController = StreamController<Map<String, dynamic>>();

  final StreamController<String> _loginStatusController =
      StreamController<String>();

  Stream<String> get loginStatus => _loginStatusController.stream;

  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;

  LoginBloc() {
    _phoneNumberController.stream.listen((phoneNumber) {
      loginUser(phoneNumber);
    });
  }

  Future<void> loginUser(String phoneNumber) async {
    final String apiUrl = 'http://192.168.1.41/RUPIYOSELLER_API/Login.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone_number': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          print('Login successful');

          // Save the phone number to SharedPreferences
          _savePhoneNumber(phoneNumber);

          // Notify UI about the login status
          _loginStatusController.add('success');

          //Load user data after successful login
          _loadUserData(phoneNumber);
        } else {
          print('Error: ${result['message']}');
          _loginStatusController.add('error');
        }
      } else {
        print('Failed to login. Error code: ${response.statusCode}');
        _loginStatusController.add('error');
      }
    } catch (e) {
      print('Error during login: $e');
      _loginStatusController.add('error');
    }
  }

  Future<void> _loadUserData(String phoneNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.41/RUPIYOSELLER_API/getUser.php?phone_number=$phoneNumber'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        print('User details: $userData');
        _userDataController.add(userData);
      } else {
        print('Error loading user data: ${response.statusCode}');
        _userDataController.addError('Error loading user data');
      }
    } catch (e) {
      print('Error loading user data: $e');
      _userDataController.addError('Error loading user data');
    }
  }

  Future<void> _savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phoneNumber);
  }

  void dispose() {
    _phoneNumberController.close();
    _userDataController.close();
    _loginStatusController.close();
  }
}
