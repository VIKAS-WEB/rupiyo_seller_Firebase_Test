import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SelectSubscription.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SellerDetailsForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetEmail extends StatefulWidget {
  @override
  State<GetEmail> createState() => _GetEmailState();
}

class _GetEmailState extends State<GetEmail> {
  bool isEmailVerified = false;
  int currentPage = 0;
  TextEditingController EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor, // Change this color as needed
    ));
    Future<void> printSharedPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String phoneNumber = prefs.getString('PhoneNumberValue') ?? '';
      String emailValue = prefs.getString('valueFromEmailPage') ?? '';

      print('Phone Number: $phoneNumber');
      print('Email Value: $emailValue');
    }

    // ignore: non_constant_identifier_names
    Future<void> EmailSubmit(String email, String psw) async {
      // Replace with your actual API endpoint
      const String apiUrl =
          'http://192.168.1.15/RUPIYOSELLER_API/EmailAndPassword.php';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'Email': email,
            'PhoneNumber': psw,
          },
        );

        // Check the content type of the response
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          // If the response is JSON, decode it
          final responseData = json.decode(response.body);
          // Handle the JSON response as needed
          print(responseData);
        } else {
          // If the response is not JSON, handle it as an error
          print('Unexpected response: ${response.body}');
          // You can throw an exception or handle it in another way
          throw Exception('Unexpected response format');
        }
      } catch (error) {
        // Handle network or other errors
        print('Error: $error');
        // You can show an error message to the user or handle it in another way
      }
    }

    bool _isValidEmail = false;
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Enter Email Address',
                                style:
                                    Theme.of(context).textTheme.headlineMedium
                                // TextStyle(
                                //   fontSize: 50,
                                //   fontWeight: FontWeight.w500,
                                //   color:
                                //       Colors.white, // Set text color to white
                                // ),
                                ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Stay in the loop and never miss out on the latest updates! To ensure you are always in the know about exciting developments, promotions, and exclusive contents',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge, // Set text color to white
                            ),
                          ],
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
                            //_isValidEmail = _isValidEmailAddress(value);
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Icon(
                              CupertinoIcons.mail,
                              size: 30,
                              color: AppColor.BackgroundColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.BackgroundColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.BackgroundColor)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.BackgroundColor)),
                            labelText: 'Enter Email ID',
                            labelStyle: TextStyle(
                                color: AppColor.BackgroundColor, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Lottie.asset(
                            'Assets/LottieAssets/e.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //         onPressed: () {

                    //         },
                    //         child: const Text('Submit')),
                    //   ],
                    // ),
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
                            CupertinoIcons.envelope_circle_fill,
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
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String psw =
                              prefs.getString('PhoneNumberValue') ?? '';
                          String email = EmailController.text;

                          prefs.setString('valueFromEmailPage', email);

                          EmailSubmit(psw, email);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 200),
                              type: PageTransitionType.leftToRight,
                              child: const SelectSubscription(),
                            ),
                          );
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
