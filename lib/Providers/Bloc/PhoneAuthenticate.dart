import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class PhoneNumberBloc {
  
  final _phoneNumberController = StreamController<String>();
  final _otpSendingController = StreamController<bool>();
  final _verificationIdController = StreamController<String>();

  // Inputs
  Function(String) get setPhoneNumber => _phoneNumberController.sink.add;

  // Outputs
  Stream<bool> get otpSendingStream => _otpSendingController.stream;
  Stream<String> get verificationIdStream => _verificationIdController.stream;

  PhoneNumberBloc() {
    _initialize();
  }

  void _initialize() {
    _phoneNumberController.stream.listen((phoneNumber) async {
      if (phoneNumber.isNotEmpty && phoneNumber.length == 10) {
        await sendOtp(phoneNumber);
      }
    });
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      // Notify listeners that OTP sending is in progress
      _otpSendingController.add(true);
      // TODO: Add logic to send OTP using Firebase or your preferred service
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {
          // Show an error dialog
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
        //phoneNumber: fullPhoneNumber,
      );
      // For example:
      // await FirebaseAuth.instance.verifyPhoneNumber(...);

      // Simulate a delay for demonstration purposes
      await Future.delayed(const Duration(seconds: 2));

      // Notify listeners that OTP sending is complete
      _otpSendingController.add(false);

      // TODO: Obtain the verification ID from the OTP sending process
      // For example:
      // final verificationId = '123456';

      final verificationId =
          '123456'; // Replace with your actual verification ID
      _verificationIdController.add(verificationId);
    } catch (error) {
      // Handle errors during OTP sending
      print('Error during OTP sending: $error');
      _otpSendingController.add(false);
    }
  }

  // Clean up resources when the bloc is disposed
  void dispose() {
    _phoneNumberController.close();
    _otpSendingController.close();
    _verificationIdController.close();
  }
}
