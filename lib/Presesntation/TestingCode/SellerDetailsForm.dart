import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rupiyo_seller/CountryCode.dart';
import 'package:rupiyo_seller/Models/Shop.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Services/ShopService.dart';

class SellerDetailForms extends StatefulWidget {
  @override
  _SellerDetailFormsState createState() => _SellerDetailFormsState();
}

class _SellerDetailFormsState extends State<SellerDetailForms> {
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
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     // Insert shop data into the database
    //     await _shopService.insertShop(
    //       Shop(
    //         shopName: nameController.text,
    //         categories: CategoriesController.text,
    //         Address: ShopNo.text,
    //       ),
    //     );
    //   } catch (e) {
    //     print('Error: $e');
    //     // Handle the error gracefully
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor, // Change this color as needed
    ));
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";

    return Scaffold(
      backgroundColor: AppColor.mainColor,
      appBar: AppBar(
        toolbarHeight: 45,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.mainColor, // Set the app bar color to red
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 0),
            child: Icon(
              CupertinoIcons.arrow_left,
              color: AppColor.BackgroundColor, // Set icon color to white
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                color: AppColor.BackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.mainColor),
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 40,
                            child: Center(
                                child: Text(
                              'Please Fill Your Shop Details',
                              style: Theme.of(
                                context,
                              )
                                  .textTheme
                                  .titleMedium
                                  ?.apply(color: AppColor.BackgroundColor),
                            ))),
                      ],
                    ),
                    Stepper(
                      connectorThickness: 1.2,
                      connectorColor:
                          const MaterialStatePropertyAll(AppColor.mainColor),
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
                                      borderSide:
                                          BorderSide(color: AppColor.mainColor),
                                    ),
                                    labelText: 'Name of Your Shop',
                                    labelStyle: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please Enter The shop name'),
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
                          state: _currentStep <= 0
                              ? StepState.editing
                              : StepState.complete,
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
                              fontSize: 15,
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
                                            label: const Text(
                                                'Fruits And Vegitable'),
                                            onSelected: (bool value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    selectedChipLabel.isNotEmpty
                                                        ? '$selectedChipLabel selected'
                                                        : '$selectedChipLabel Deselected',
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                              handleChipSelection(
                                                  'Fruits And Vegitable');
                                              // setState(() {
                                              FruitsAndVegitable =
                                                  !FruitsAndVegitable;
                                              // });
                                            }),
                                        FilterChip(
                                            selected: PackagedFood,
                                            label: const Text('Packaged Food'),
                                            onSelected: (bool value) {
                                              // Show a Snackbar with the name of the selected FilterChip
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    selectedChipLabel.isNotEmpty
                                                        ? '$selectedChipLabel selected'
                                                        : '$selectedChipLabel was not selected',
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                              PackagedFood = !PackagedFood;
                                              handleChipSelection(
                                                  'Packaged Food');
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    selectedChipLabel.isNotEmpty
                                                        ? '$selectedChipLabel selected'
                                                        : '$selectedChipLabel Deselected',
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                              handleChipSelection(
                                                  'Sweet Cravings');
                                              // setState(() {
                                              SweetCravings = !SweetCravings;
                                              // });
                                            }),
                                        FilterChip(
                                            selected: MasalaAndDryFruits,
                                            label: const Text(
                                                'Masala And Dry fruits'),
                                            onSelected: (bool value) {
                                              // Show a Snackbar with the name of the selected FilterChip
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    selectedChipLabel.isNotEmpty
                                                        ? '$selectedChipLabel selected'
                                                        : '$selectedChipLabel deselected',
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                              MasalaAndDryFruits =
                                                  !MasalaAndDryFruits;
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
                              fontSize: 15,
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
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
                          color: AppColor.BackgroundColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.circle_fill,
                          color: AppColor.BackgroundColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.circle_fill,
                          color: AppColor.BackgroundColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.doc_circle_fill,
                          color: AppColor.BackgroundColor,
                          size: 45,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                          Navigator.push(
                          context,
                          PageTransition(
                          duration: const Duration(milliseconds: 200),
                          type: PageTransitionType.leftToRight,
                          child: const Dashboard(),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor
                              .BackgroundColor, // Button background color
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColor.mainColor, // Icon color
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
        ),
      );

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
