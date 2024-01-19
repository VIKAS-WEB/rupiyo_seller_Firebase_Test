import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:http/http.dart' as http;

class StepperForm extends StatefulWidget {
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _currentStep = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController CategoriesController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> insertRecord() async {
    if (nameController.text != "" ||
        phoneController.text != "" ||
        CategoriesController.text != "" ||
        emailController.text != "") {
      try {
        String uri = "http://192.168.29.95/RupiyoSeller_API/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "ShopName": nameController.text,
          "Categories": CategoriesController.text,
          "PhoneNumber": phoneController.text,
          "Email_ID": emailController.text,
        }
        );
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print('Record Insert Succesfull');
        } else {
          print('Some Issue There');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All Fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Text(
            'Please Add Basic Details Of Shop',
            style: TextStyle(color: AppColor.BackgroundColor),
          ),
          Stepper(
            elevation: 2,
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 2) {
                setState(() {
                  _currentStep += 1;
                });
              } else {
                // Perform any final actions here
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
                title: const Text('Step 1'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Name of Your Shop'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform any actions on button click
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                isActive: _currentStep == 0,
              ),
              Step(
                title: const Text('Step 2'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: CategoriesController,
                      decoration:
                          const InputDecoration(labelText: 'Categories'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform any actions on button click
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                isActive: _currentStep == 0,
              ),
              Step(
                title: const Text('Step 3'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(labelText: 'PhoneNumber'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform any actions on button click
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                isActive: _currentStep == 1,
              ),
              Step(
                title: const Text('Step 4'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform any actions on button click
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                isActive: _currentStep == 1,
              ),
              Step(
                title: const Text('Step 5'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Perform any final actions on button click
                      },
                      child: const Text('Finish'),
                    ),
                  ],
                ),
                isActive: _currentStep == 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
