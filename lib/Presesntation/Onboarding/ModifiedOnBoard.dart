import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MOnBoarding extends StatefulWidget {
  const MOnBoarding({Key? key}) : super(key: key);

  @override
  State<MOnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<MOnBoarding> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0; // Track the current page for the progress bar

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to red
      appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.red.shade700, // Set the app bar color to red
          elevation: 0,
          leading: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.white, // Set icon color to white
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
                decoration: BoxDecoration(
                  color: Colors.red.shade700, // Set the container color to red
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: FittedBox(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
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
                              'Please confirm your phone number\nand we will guide you through setting\nup your seller profile.',
                              style: TextStyle(
                                  color:
                                      Colors.white), // Set text color to white
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Colors.white), // Set text color to white
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 230,
                                  height: 40,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors
                                              .white, // Set border color to white
                                        ),
                                      ),
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Bottom Dot Progress Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3, // Number of dots
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentPage
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    // Container Button Wrapped with Circle Shape
                    // Container(
                    //   width: 60,
                    //   height: 60,
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.red, // Set button background color to red
                    //   ),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       // Add your button click logic here
                    //     },
                    //     icon: const Icon(
                    //       Icons.arrow_forward,
                    //       color: Colors.white, // Set icon color to white
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



