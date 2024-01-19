import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/EmailFieldTesting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyTEST2 extends StatefulWidget {
  //late String verificationId;

  OtpVerifyTEST2({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpVerifyTEST2> createState() => _OtpVerifyTEST2State();
}

class _OtpVerifyTEST2State extends State<OtpVerifyTEST2> {
  int countdown = 30;
  bool showResendButton = false;

  bool _isSuccess = false;
  TextEditingController _otpController = TextEditingController();

  bool _isVerifying = false;
  String savedPhoneNumber = "Default Value";
  @override
  void initState() {
    super.initState();
    _loadSavedValue();
    startCountdown(); // Call to load saved phone number
  }

  _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Replace 'your_key' with the actual key you used when saving the value
      savedPhoneNumber = prefs.getString('PhoneNumberValue') ?? "Default Value";
    });
  }

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
                height: MediaQuery.of(context).size.height / 1.4,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please Type The Verification Code sent To\n+91${savedPhoneNumber}',
                            style: const TextStyle(
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
                            // Perform OTP validation
                            //verifyOTP(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "If you didn't receive a code!",
                          style: TextStyle(color: AppColor.BackgroundColor),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        showResendButton
                            ? SizedBox(
                                width: 98,
                                height: 25,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.BackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Your resend logic here
                                    // resendCode();
                                  
                                  },
                                  child: const Text(
                                    'Resend',
                                    style: TextStyle(
                                        color: AppColor.mainColor,
                                        fontSize: 13),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 98,
                                height: 25,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.BackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Your resend logic here
                                    // resendCode();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '$countdown s',
                                    style: const TextStyle(
                                        color: AppColor.mainColor,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 180,
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
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.circle,
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
                            Icons.circle,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.circle,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          // Navigate only if not verifying
                          // if (!_isVerifying) {
                          //   verifyOTP(_otpController.text);
                          // }
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

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel(); // Stop the timer
        setState(() {
          showResendButton = true;
        });
      }
    });
  }

  // void verifyOTP(String enteredOTP) async {
  //   setState(() {
  //     _isVerifying = true;
  //   });

  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: widget.verificationId,
  //       smsCode: enteredOTP,
  //     );

  //     await FirebaseAuth.instance
  //         .signInWithCredential(credential)
  //         .then((value) {
  //       // _showNotification('Welcome To Rupiyo',
  //       //     'You are Only One Step Away For Grow Your Business.');
  //       // Successful sign-in, navigate to the next screen
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => GetEmail(),
  //         ),
  //       );
  //     });

  //     setState(() {
  //       _isVerifying = false;
  //     });
  //   } catch (ex) {
  //     setState(() {
  //       _isVerifying = false;
  //     });

  //     // Show a dialog indicating wrong OTP
  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: AppColor.BackgroundColor,
  //           elevation: 0,
  //           title: Center(child: const Text('Wrong OTP')),
  //           content: const Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 Icons.error,
  //                 color: Colors.red,
  //                 size: 40,
  //               ),
  //               SizedBox(height: 10),
  //               Text('The entered OTP is incorrect.'),
  //             ],
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColor.mainColor,
  //                   shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(7)))),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Center(
  //                   child: const Text(
  //                 'Retry',
  //                 style: TextStyle(color: AppColor.BackgroundColor),
  //               )),
  //             ),
  //           ],
  //         );
  //       },
  //     );

  //     print("Error during OTP verification: $ex");
  //   }
  // }
}

// Future<void> _showNotification(String title, String body) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'your_channel_id',
//     'your_channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );

//   await FlutterLocalNotificationsPlugin().show(
//     0,
//     title,
//     body,
//     platformChannelSpecifics,
//     payload: 'item x',
//   );
// }
