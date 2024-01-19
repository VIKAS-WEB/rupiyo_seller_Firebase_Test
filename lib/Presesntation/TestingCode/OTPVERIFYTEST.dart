import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/EmailFieldTesting.dart';

class OtpVerifyTEST extends StatefulWidget {
  final String phoneNumber;

  OtpVerifyTEST({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpVerifyTEST> createState() => _OtpVerifyTESTState();
}

class _OtpVerifyTESTState extends State<OtpVerifyTEST> {
  bool _isSuccess = false;
  TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor,
    ));

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You will receive an OTP on the\nregistered mobile number you have entered',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 0,
                        bottom: 0,
                      ),
                      child: SizedBox(
                        width: 300,
                        child: PinCodeTextField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _otpController,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            inactiveColor: AppColor.BackgroundColor,
                            selectedColor: AppColor.BackgroundColor,
                            selectedFillColor: AppColor.textColor,
                            inactiveFillColor: AppColor.BackgroundColor,
                            activeFillColor: AppColor.mainColor,
                          ),
                          enableActiveFill: true,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textStyle: const TextStyle(color: AppColor.BackgroundColor),
                          keyboardType: TextInputType.number,
                          hintStyle: const TextStyle(color: AppColor.BackgroundColor),
                          backgroundColor: AppColor.mainColor,
                          appContext: context,
                          length: 6,
                          onChanged: (value) {
                            // Handle OTP input changes
                          },
                          onCompleted: (value) {
                            // Handle when the OTP input is completed
                            print("Completed: $value");
                            // Perform OTP validation
                            verifyOTP(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Lottie.asset(
                              'Assets/LottieAssets/Otp.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
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
                            CupertinoIcons.circle_fill,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.exclamationmark_shield_fill,
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
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          // Navigate only if not verifying
                          if (!_isVerifying) {
                            verifyOTP(_otpController.text);
                          }
                        },
                        child: _isVerifying
                            ? const CircularProgressIndicator(
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.mainColor,
                                ),
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.mainColor,
                                ),
                                child: const Icon(
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

  void verifyOTP(String enteredOTP) async {
    setState(() {
      _isVerifying = true;
    });

    try {
      // Replace 'YOUR_API_KEY' with your Fast2SMS API key
      const apiKey = 'YOUR_API_KEY';
      final apiUrl = 'https://www.fast2sms.com/dev/verify';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'authorization': apiKey,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'authorization': apiKey,
          'otp': enteredOTP,
          'message': 'OTP is valid',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['return'] == true) {
          // OTP validation successful, navigate to the next screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetEmail(),
            ),
          );
        } else {
          // Show a dialog indicating wrong OTP
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColor.BackgroundColor,
                elevation: 0,
                title: Center(child: const Text('Wrong OTP')),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text('The entered OTP is incorrect.'),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: AppColor.BackgroundColor),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle other HTTP status codes
        print('Failed to validate OTP. Status code: ${response.statusCode}');
      }

      setState(() {
        _isVerifying = false;
      });
    } catch (ex) {
      setState(() {
        _isVerifying = false;
      });

      // Show a dialog for any other errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColor.BackgroundColor,
            elevation: 0,
            title: Center(child: const Text('Error')),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text('Error during OTP validation.'),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: AppColor.BackgroundColor),
                  ),
                ),
              ),
            ],
          );
        },
      );

      print("Error during OTP validation: $ex");
    }
  }
}
