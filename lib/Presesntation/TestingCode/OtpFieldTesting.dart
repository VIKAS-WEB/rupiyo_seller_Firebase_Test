import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/EmailFieldTesting.dart';

class OtpVerify extends StatefulWidget {
  late String verificationId;

  OtpVerify({super.key, required this.verificationId});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor, // Change this color as needed
    ));

    int currentPage = 0;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.mainColor, // Set the app bar color to red
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white, // Set icon color to white
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
                  color: AppColor.mainColor, // Set the container color to red
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
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You will Recieve an OTP on the\nRegistered mobile number you have Entered',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            textAlign:
                                TextAlign.center, // Set text color to white
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
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
                              activeFillColor: AppColor.mainColor),
                          enableActiveFill: true,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          textStyle:
                              const TextStyle(color: AppColor.BackgroundColor),
                          keyboardType: TextInputType.number,
                          hintStyle:
                              const TextStyle(color: AppColor.BackgroundColor),
                          backgroundColor: AppColor.mainColor,
                          appContext: context,
                          length: 6,
                          onChanged: (value) {
                            // Handle OTP input changes
                          },
                          onCompleted: (value) {
                            // Handle when the OTP input is completed
                            print("Completed: $value");
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //   SizedBox(width: 10,),
                    //   Text('3', style: TextStyle(color: AppColor.textColor3),),

                    //   ],
                    // ),

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
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.circle_fill,
                            color: AppColor.mainColor,
                            size: 16,
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
                          try {
                            PhoneAuthCredential credential =
                                await PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: _otpController.text.toString());
                            FirebaseAuth.instance
                                .signInWithCredential(credential)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetEmail(),
                                  ));
                            });
                          } catch (ex) {
                            print(ex.toString());
                          }
                          //   Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     duration: Duration(milliseconds: 200),
                          //     type: PageTransitionType.leftToRight,
                          //     child: GetEmail(),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                AppColor.mainColor, // Button background color
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white, // Icon color
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
