import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 4; i++) {
      indicators.add(_buildDotIndicator(i == currentPage));
    }

    return indicators;
  }
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.mainColor, // Set the app bar color to red
        elevation: 0,
        leading: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.white, // Set icon color to white
          size: 30,
        ),
      ),
      body: Stack(
            children: [
            PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              PhoneNumberInput(),
              PhoneNumberInput(),
              
              //buildPage(),
            
            ],
          ),
          Positioned(
            bottom: 70,
            left: 20,
            right: 0,
            child: Row(
              children: _buildPageIndicator(),
            )
          ),
          Positioned(

            bottom: 50,
            left: 290,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (currentPage < 3) {
                  _pageController.animateToPage(
                    currentPage + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.mainColor, // Button background color
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white, // Icon color
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            index == currentPage ? Colors.white : Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
    return SingleChildScrollView(
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
                                fontSize: 38,
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
                                      Colors.white, fontSize: 16), // Set text color to white
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
                                  fontSize: 30,
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
                height: MediaQuery.of(context).size.height / 6,
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
      );
  }
}
 Widget _buildDotIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
       height: 13.0,
      width: isActive ? 12.0 : 12.0,
      decoration: BoxDecoration(
        color: isActive ? AppColor.mainColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
