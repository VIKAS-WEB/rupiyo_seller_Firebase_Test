// ignore_for_file: use_build_context_synchronously

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
import 'package:rupiyo_seller/Presesntation/TestingCode/EmailFieldTesting.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OTPVERIFYTEST.dart';
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

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  set number(PhoneNumber number) {}

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = TextEditingController();
  String VerificationId = '';
  bool isOtpSending = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor, // Change this color as needed
    ));

    Future<void> submitForm() async {
      const String apiUrl =
          'http://192.168.29.95/RUPIYOSELLER_API/PhoneNumber.php';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'PhoneNumber': phoneNumberController.text,
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          // Check if the insertion was successful
          if (responseData['success'] == true) {
            // Show a success message
            // ignore: use_build_context_synchronously
            showSuccessSnackBar(context, "Otp Sended Successfully");
            await Future.delayed(const Duration(milliseconds: 1200));
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     duration: const Duration(milliseconds: 200),
            //     type: PageTransitionType.leftToRight,
            //     child: OtpVerify(),
            //   ),
            // );
          } else {
            // Handle other cases if needed
            print("Insertion failed. Server response: $responseData");
          }
        } else {
          // Handle other HTTP status codes
          print("HTTP Error: ${response.statusCode}");
        }
      } catch (error) {
        // Handle any exceptions that occur during the request
        print("Error: $error");
      }
    }

    //Classes
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String fullPhoneNumber = '+91${phoneNumberController.text}';
    final TextEditingController phonecontroller = TextEditingController();
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    String PN = phonecontroller.text;
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
                  color: AppColor.mainColor, // Set the container color to red
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
                              'Please confirm your phone number\nYou Will Recieve an OTP on The Registered\nMobile Number You Have Entered.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16), // Set text color to white
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      //PhoneNumberField
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
                    ), //Phone number Field Ends here
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
                child: SizedBox(
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
                          String phoneNumber =
                              phoneNumberController.text.trim();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'PhoneNumberValue', phoneNumberController.text);
                          if (phoneNumber.isEmpty || phoneNumber.length != 10) {
                            // Show an error message for invalid phone number
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColor.BackgroundColor,
                                  elevation: 0,
                                  title: const Text('Error'),
                                  content: const Text(
                                    'Please enter a valid phone number.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => GetEmail(),
                          //   ),
                          // );

                          try {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException ex) {
                                // Show an error dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColor.BackgroundColor,
                                      elevation: 0,
                                      title: const Text('Error'),
                                      content: const Text(
                                        'Failed to send OTP. Please try again.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
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
                              phoneNumber: fullPhoneNumber,
                            );
                          } catch (error) {
                            print(
                                "Error During Phone Number Verification: $error");
                          } finally {
                            // Close the sending OTP dialog after the try-catch block
                            Navigator.pop(context);

                            // Update the state to reflect the end of OTP sending process
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
                                      AppColor.BackgroundColor,
                                    ),
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

class GetPhoneNumber extends StatelessWidget {
  const GetPhoneNumber({
    super.key,
    required this.number,
    required this.phonecontroller,
  });

  final PhoneNumber number;
  final TextEditingController phonecontroller;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      initialValue: number,
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      textFieldController: phonecontroller,
      formatInput: true,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
