import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OtpFieldTesting.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/pn.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ),
  );
}

// Save TextField value to SharedPreferences
Future<void> saveToSharedPreferences(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

class SAVED extends StatefulWidget {
  const SAVED({Key? key});

  @override
  State<SAVED> createState() => _SAVEDState();
}

class _SAVEDState extends State<SAVED> {
  set number(PhoneNumber number) {}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = TextEditingController();
  bool isOtpSending = false;

  Future<void> submitForm(String fullPhoneNumber) async {
    const String apiUrl =
        'http://192.168.1.15/RUPIYOSELLER_API/PhoneNumber.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'PhoneNumber': '+91${phoneNumberController.text}',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          showSuccessSnackBar(context, "Otp Sended Successfully");
          await Future.delayed(const Duration(milliseconds: 1200));
        } else {
          print("Insertion failed. Server response: $responseData");
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor, // Change this color as needed
    ));

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColor.mainColor, // Set the container color to blue
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Animate(
                            effects: const [
                              FadeEffect(delay: Duration(milliseconds: 1000))
                            ],
                            child: const Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w500,
                                color: Colors.white, // Set text color to white
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Animate(
                            effects: const [
                              SlideEffect(delay: Duration(milliseconds: 2300)),
                              FadeEffect()
                            ],
                            child: const Text(
                              'Please confirm your phone number\nYou Will Receive an OTP on The Registered\nMobile Number You Have Entered.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Animate(
                          effects: const [
                            FadeEffect(delay: Duration(milliseconds: 3000)),
                            SlideEffect()
                          ],
                          child: pn(
                            countryCode: '+91',
                            phoneNumberController: phoneNumberController,
                            onPhoneNumberChanged: (phoneNumber) {
                              print('Phone Number Changed: $phoneNumber');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Animate(
                        effects: const [
                          FadeEffect(delay: Duration(milliseconds: 3400))
                        ],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 260,
                              child: Lottie.asset(
                                'Assets/LottieAssets/PhoneAnimation.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            CupertinoIcons.phone_circle_fill,
                            color: AppColor.mainColor,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.circle_fill,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.circle_fill,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.circle_fill,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SpinKitThreeBounce(
                                      color: AppColor.mainColor,
                                      size: 40,
                                    ),
                                    SizedBox(height: 16),
                                    Text('Sending OTP...'),
                                  ],
                                ),
                              );
                            },
                          );
                          String fullPhoneNumber =
                              '+91${phoneNumberController.text}';
                          await submitForm(fullPhoneNumber);

                          setState(() {
                            isOtpSending = true;
                          });

                          try {
                            await _auth.verifyPhoneNumber(
                              phoneNumber: fullPhoneNumber,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException ex) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpVerify(
                                      verificationId: verificationId,
                                    ),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                              timeout: const Duration(seconds: 60),
                            );
                          } catch (error) {
                            print(
                                "Error During Phone Number Verification: $error");
                          } finally {
                            Navigator.pop(context); // Close the dialog
                            setState(() {
                              isOtpSending = false;
                            });
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.mainColor,
                          ),
                          child: isOtpSending
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
