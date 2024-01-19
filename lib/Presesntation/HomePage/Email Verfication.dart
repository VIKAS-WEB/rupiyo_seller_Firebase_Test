import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailVerfication extends StatefulWidget {
  const EmailVerfication({super.key});

  @override
  State<EmailVerfication> createState() => _EmailVerficationState();
}

class _EmailVerficationState extends State<EmailVerfication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: AppColor.BackgroundColor,
          ),
        ),
        title: const Text(
          'Email Verfication',
          style: TextStyle(color: AppColor.BackgroundColor, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                  children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.4,
                    height: 260,
                    child: Lottie.asset(
                      'Assets/LottieAssets/EmailVerify.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            
            Column(
              children: [
                const Text(
                  'Almost Done!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'A Verification eamil has been send to Your Email.'),
                const Text(
                  'Id Please check your email and follow the link to activate your Gmail Account.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColor.mainColor,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColor.mainColor),
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text(
                      'Verify Email',
                      style: TextStyle(
                          color: AppColor.BackgroundColor, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Did Not receive an email?'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Resend',
                      style: TextStyle(fontSize: 15, color: AppColor.mainColor),
                    ),
                  ],
                ),
              ],
            ),
                  ],
                ),
          )),
    );
  }
}
