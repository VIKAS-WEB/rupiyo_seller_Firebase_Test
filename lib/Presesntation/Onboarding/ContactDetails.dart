import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rupiyo_seller/CountryCode.dart';
import 'package:rupiyo_seller/Database/DatabaseHelper.dart';
import 'package:rupiyo_seller/Database/SellerDetailsDatabase.dart';
import 'package:rupiyo_seller/Models/SellerDetails.dart';
import 'package:rupiyo_seller/Models/Shop.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/Address.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/SellerDetails.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/SendingPage.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/Welcome.dart';
import 'package:rupiyo_seller/Providers/SellerDataProvider.dart';
import 'package:rupiyo_seller/Services/ShopService.dart';
import 'package:rupiyo_seller/StepperTest.dart';
import 'package:http/http.dart' as http;

class TESTING extends StatefulWidget {
  const TESTING({super.key});

  @override
  State<TESTING> createState() => _TESTINGState();
}

class _TESTINGState extends State<TESTING> {
  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 4; i++) {
      indicators.add(_buildDotIndicator(i == currentPage));
    }
    return indicators;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int lastPage = 3; // Adjust this value based on your total number of pages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.mainColor, // Set the app bar color to red
        elevation: 0,
        leading: InkWell(
          onTap: () {
            if (currentPage < 4) {
              _pageController.animateToPage(
                currentPage - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            //Navigator.of(context);
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  const PhoneNumberInput(),
                  otp(),
                  EmailNumberInput(),
                  StepperForm(), //buildPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: _buildPageIndicator()),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (currentPage < lastPage) {
                            _pageController.animateToPage(
                              currentPage + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WelcomeScreen()));
                          }
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
                ],
              ),
            ),
          ],
        ),
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

Widget _buildDotIndicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    height: 13.0,
    width: isActive ? 12.0 : 12.0,
    decoration: BoxDecoration(
      color: isActive ? AppColor.mainColor : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

bool _isValidEmailAddress(String email) {
  // Use a regular expression to check if the email format is valid
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  return emailRegex.hasMatch(email);
}

//Email Number Input Class
class EmailNumberInput extends StatefulWidget {
  @override
  State<EmailNumberInput> createState() => _EmailNumberInputState();
}

class _EmailNumberInputState extends State<EmailNumberInput> {
  int currentPage = 0;
  TextEditingController EmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> EmailSubmit() async {
      final String apiUrl =
          'http://192.168.1.34/RUPIYOSELLER_API/EmailAddress.php'; // Replace with your actual API endpoint

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'EmailAddress': EmailController.text,
        },
      );

      final responseData = json.decode(response.body);

      // Handle the response as needed
      print(responseData);
    }

    bool _isValidEmail = false;
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
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Enter Email Address',
                              style: TextStyle(
                                fontSize: 39,
                                fontWeight: FontWeight.w500,
                                color: Colors.white, // Set text color to white
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Stay in the loop and never miss out on the latest updates!\nTo ensure you are always in the know about exciting developments,\npromotions, and exclusive contents',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20), // Set text color to white
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _isValidEmail = _isValidEmailAddress(value);
                        });
                      },
                      controller: EmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                          color: AppColor.BackgroundColor, fontSize: 16),
                      cursorColor: AppColor.BackgroundColor,
                      cursorWidth: 1,
                      cursorHeight: 20,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          prefixIcon: Icon(
                            CupertinoIcons.mail,
                            color: AppColor.BackgroundColor,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.BackgroundColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.BackgroundColor)),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.BackgroundColor)),
                          labelText: 'Enter Email ID',
                          labelStyle: TextStyle(
                              color: AppColor.BackgroundColor, fontSize: 14)),
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
                          'Assets/LottieAssets/e.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            EmailSubmit();
                          },
                          child: const Text('Submit')),
                    ],
                  ),
                ],
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
//Email Field Ends Here

//Phone Number Input Class
class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitForm() async {
      final String apiUrl =
          'http://192.168.1.34/RUPIYOSELLER_API/PhoneNumber.php'; // Replace with your actual API endpoint

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'PhoneNumber': phoneNumberController.text,
        },
      );

      final responseData = json.decode(response.body);

      // Handle the response as needed
      print(responseData);
    }

    //Classes
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    String initialCountry = 'IN'; // Initial country code (India)
    String phoneNumber = '';
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: Animate(
                          effects: const [
                            FadeEffect(delay: Duration(milliseconds: 3000)),
                            SlideEffect()
                          ],
                          child: Container(
                            //margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColor.BackgroundColor,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: AppColor.BackgroundColor, width: 1)),
                            width: 280,
                            height: 35,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: InternationalPhoneNumberInput(
                                key: _formKey,
                                validator: (value) {
                                  print("Input value: $value");
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid phone number';
                                  }
                                  // Add more phone number validation if needed
                                  return null;
                                },
                                // searchBoxDecoration: InputDecoration(
                                //   border: OutliInputBorder()
                                // ),
                                selectorButtonOnErrorPadding: 0,
                                spaceBetweenSelectorAndTextField: 0,
                                selectorTextStyle:
                                    const TextStyle(color: AppColor.textColor),
                                textStyle:
                                    const TextStyle(color: AppColor.textColor),
                                initialValue: number,
                                selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET),
                                onInputChanged: (PhoneNumber phoneNumber) {
                                  print(
                                      "Input value: ${phoneNumber?.phoneNumber}");
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                },
                                ignoreBlank: false,
                                textFieldController: phoneNumberController,
                                formatInput: true,
                                cursorColor: AppColor.textColor,
                                inputDecoration: const InputDecoration(
                                  hintText: 'Enter Phone Number',
                                  hintStyle: TextStyle(
                                      color: AppColor.textColor2, fontSize: 15),
                                  // enabledBorder: OutlineInputBorder(
                                  //  borderSide: BorderSide(width: 1)
                                  // ),
                                  contentPadding: EdgeInsets.all(15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Positioned(
                      //   left: 97,
                      //   top: 2,
                      //   child: Container(
                      //     height: 45,
                      //     width: 1,
                      //     color: Colors.black.withOpacity(0.13),
                      //   ),
                      // ),

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
                  // width: 60,
                  // height: 60,
                  //     decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.red, // Set button background color to red
                  //     ),
                  //     child: IconButton(
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
//Ends Here

//Otp Screen Area
class otp extends StatefulWidget {
  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter OTP',
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
                          'You will Recieve an OTP on the\nRegistered mobile number you have Entered',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16), // Set text color to white
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 0, bottom: 30),
                    child: SizedBox(
                      width: 300,
                      child: PinCodeTextField(
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
                    height: 20,
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
//Otp Screen Area Ends Here

//Seller Basic Information Form
class StepperForm extends StatefulWidget {
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  final ShopService _shopService = ShopService();

  String selectedChipLabel = '';
  bool FruitsAndVegitable = false;
  bool PackagedFood = false;
  bool SweetCravings = false;
  bool MasalaAndDryFruits = false;
  int _currentStep = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController CategoriesController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController ShopNo = TextEditingController();
  TextEditingController BuildingAndBlockNo = TextEditingController();
  TextEditingController LandMarkAndAreaName = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _initializeDatabase() async {
    await _shopService.initializeDatabase();
  }

  Future<void> _insertRecord() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Insert shop data into the database
        await _shopService.insertShop(
          Shop(
            shopName: nameController.text,
            categories: CategoriesController.text,
            Address: ShopNo.text,
          ),
        );
      } catch (e) {
        print('Error: $e');
        // Handle the error gracefully
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.4,
          decoration: const BoxDecoration(
            color: AppColor.BackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Stepper(
            connectorThickness: 1.2,
            connectorColor: const MaterialStatePropertyAll(AppColor.mainColor),
            elevation: 0,
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_formKey.currentState!.validate()) {
                _insertRecord();
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else {
                  // Perform any final actions here
                }
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            steps: [
              Step(
                title: const Text(
                  'Shop',
                  style: TextStyle(
                    color: AppColor.BackgroundColor,
                    fontSize: 20,
                  ),
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: AppColor.mainColor,
                        style: const TextStyle(
                          color: AppColor.textColor,
                          fontSize: 18,
                        ),
                        controller: nameController,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.mainColor),
                          ),
                          labelText: 'Name of Your Shop',
                          labelStyle: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please Enter The shop name'),
                              ),
                            );
                            return 'Please enter the name of your shop';
                          } else {
                            SuccessDialog();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      //   // ElevatedButton(
                      //   //   style: ElevatedButton.styleFrom(
                      //   //       backgroundColor: AppColor.BackgroundColor,
                      //   //       elevation: 0,
                      //   //       shape: ContinuousRectangleBorder(
                      //   //           side:
                      //   //               const BorderSide(color: AppColor.mainColor),
                      //   //           borderRadius: BorderRadius.circular(15))),
                      //   //   onPressed: () {
                      //   //     SuccessDialog();
                      //   //     insertRecord();
                      //   //   },
                      //   //   child: const Text('Add'),
                      //   // ),
                    ],
                  ),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep <= 0 ? StepState.editing : StepState.complete,
              ),
              // Step(
              //   title: const Text(
              //     'Upload Photos of Your Shop',
              //     style: TextStyle(
              //       color: AppColor.textColor,
              //       fontSize: 20,
              //     ),
              //   ),
              //   content: Column(
              //     children: [
              //       SelectableImageBoxRow(),
              //       const SizedBox(height: 20),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: AppColor.BackgroundColor,
              //             elevation: 0,
              //             shape: ContinuousRectangleBorder(
              //                 side: const BorderSide(color: AppColor.mainColor),
              //                 borderRadius: BorderRadius.circular(15))),
              //         onPressed: () {
              //           if (_formKey.currentState!.validate()) {
              //             // Perform any actions on button click
              //           }
              //         },
              //         child: const Text('Upload'),
              //       ),
              //     ],
              //   ),
              //   isActive: _currentStep == 1,
              // ),
              Step(
                title: const Text(
                  'Choose Your Product Category',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                  ),
                ),
                content: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              FilterChip(
                                  selected: FruitsAndVegitable,
                                  label: const Text('Fruits And Vegitable'),
                                  onSelected: (bool value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          selectedChipLabel.isNotEmpty
                                              ? '$selectedChipLabel selected'
                                              : '$selectedChipLabel Deselected',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    handleChipSelection('Fruits And Vegitable');
                                    // setState(() {
                                    FruitsAndVegitable = !FruitsAndVegitable;
                                    // });
                                  }),
                              FilterChip(
                                  selected: PackagedFood,
                                  label: const Text('Packaged Food'),
                                  onSelected: (bool value) {
                                    // Show a Snackbar with the name of the selected FilterChip
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          selectedChipLabel.isNotEmpty
                                              ? '$selectedChipLabel selected'
                                              : '$selectedChipLabel was not selected',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    PackagedFood = !PackagedFood;
                                    handleChipSelection('Packaged Food');
                                  }),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              FilterChip(
                                  selected: SweetCravings,
                                  label: const Text('Sweet Cravings'),
                                  onSelected: (bool value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          selectedChipLabel.isNotEmpty
                                              ? '$selectedChipLabel selected'
                                              : '$selectedChipLabel Deselected',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    handleChipSelection('Sweet Cravings');
                                    // setState(() {
                                    SweetCravings = !SweetCravings;
                                    // });
                                  }),
                              FilterChip(
                                  selected: MasalaAndDryFruits,
                                  label: const Text('Masala And Dry fruits'),
                                  onSelected: (bool value) {
                                    // Show a Snackbar with the name of the selected FilterChip
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          selectedChipLabel.isNotEmpty
                                              ? '$selectedChipLabel selected'
                                              : '$selectedChipLabel deselected',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    MasalaAndDryFruits = !MasalaAndDryFruits;
                                    handleChipSelection(
                                        'Masala And Dry Fruits');
                                  }),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                isActive: _currentStep >= 1,
              ),
              Step(
                title: const Text(
                  'Enter Your Shop Address',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                  ),
                ),
                content: const Column(
                  children: [
                    ///Adding CSC Picker Widget in app
                    Country(),
                  ],
                ),
                isActive: _currentStep >= 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future SuccessDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            elevation: 0,
            backgroundColor: AppColor.BackgroundColor,
            content: Container(
              color: AppColor.BackgroundColor,
              height: 300,
              child: Column(
                children: [
                  const Text(
                    'Successfully Added Shop Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Lottie.asset(
                      'Assets/LottieAssets/Success.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ));

  Future FailedMessage() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 300,
            child: Column(
              children: [
                const Text(
                  'Failed To Add Data',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Lottie.asset(
                    'Assets/LottieAssets/Failed.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void handleChipSelection(String chipLabel) {
    setState(() {
      selectedChipLabel = chipLabel;
    });
  }
}
//Seller Basic Form Ends Here.

//Image Selection Area
class SelectableImageBoxRow extends StatefulWidget {
  @override
  _SelectableImageBoxRowState createState() => _SelectableImageBoxRowState();
}

class _SelectableImageBoxRowState extends State<SelectableImageBoxRow> {
  int selectedBoxIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SelectableImageBox(
            imageUrl: 'Assets/Images/Combos.png',
            isSelected: selectedBoxIndex == 0,
            onTap: () => onBoxSelected(0),
          ),
          const SizedBox(
            width: 10,
          ),
          SelectableImageBox(
            imageUrl: 'Assets/Images/dmart.jpg',
            isSelected: selectedBoxIndex == 1,
            onTap: () => onBoxSelected(1),
          ),
          const SizedBox(
            width: 10,
          ),
          SelectableImageBox(
            imageUrl: 'Assets/Images/greeting.jpg',
            isSelected: selectedBoxIndex == 2,
            onTap: () => onBoxSelected(2),
          ),
          const SizedBox(
            width: 10,
          ),
          SelectableImageBox(
            imageUrl: 'Assets/Images/Combos.png',
            isSelected: selectedBoxIndex == 2,
            onTap: () => onBoxSelected(2),
          ),
          const SizedBox(
            width: 10,
          ),
          SelectableImageBox(
            imageUrl: 'Assets/Images/dmart.jpg',
            isSelected: selectedBoxIndex == 2,
            onTap: () => onBoxSelected(2),
          ),
          // Add more SelectableImageBox widgets as needed
        ],
      ),
    );
  }

  void onBoxSelected(int index) {
    setState(() {
      if (selectedBoxIndex == index) {
        selectedBoxIndex = -1; // Deselect the box if it was already selected
      } else {
        selectedBoxIndex = index;
        showImageUploadDialog(); // Show a dialog or navigate to a new screen for image upload
      }
    });
  }

  void showImageUploadDialog() {
    // Implement your image upload logic here
    // You can use a dialog, navigation, or any other method based on your app's design
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColor.BackgroundColor,
          title: const Text('Upload Image'),
          content: const Text('Implement your image upload logic here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class SelectableImageBox extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  SelectableImageBox({
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border:
              Border.all(color: isSelected ? AppColor.mainColor : Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
//Image Selection Area Ends Here
