import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.textColor3,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.BackgroundColor,
        elevation: 0,
        leading: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
          size: 30,
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
                height: screenHeight / 1.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColor.BackgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: FittedBox(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Please confirm your phone number\nand we will guide you through setting\nup your seller profile.',
                              style: TextStyle(color: AppColor.textColor2),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 230,
                                  height: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColor.BackgroundColor)),
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 6,
                child: const Row(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
