import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OtpFieldTesting.dart';

class PhoneNumberInsert extends StatefulWidget {
  const PhoneNumberInsert({super.key});

  @override
  State<PhoneNumberInsert> createState() => _PhoneNumberInsertState();
}

class _PhoneNumberInsertState extends State<PhoneNumberInsert> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number Field'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  suffixIcon: const Icon(CupertinoIcons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpVerify(
                              verificationId: verificationId,
                            ),
                          ));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: const Text('Verify Phone Number'))
        ],
      ),
    );
  }
}
