import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class StoreDetailsForm extends StatefulWidget {
  @override
  _StoreDetailsFormState createState() => _StoreDetailsFormState();
}

class _StoreDetailsFormState extends State<StoreDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ShopNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _CategoriesController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  File? _selectedImage;

  int _currentStep = 0;
  List<String> _errorMessages = ['', '', '', '', ''];
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Step Form'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / 5,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep == 4) {
                    _submitForm();
                  } else {
                    setState(() {
                      _errorMessages[_currentStep] = '';
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  setState(() {
                    _currentStep -= 1;
                  });
                },
                steps: [
                  Step(
                    title: const Text('Step 1'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _ShopNameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        Text(
                          _errorMessages[0],
                          style: const TextStyle(color: Colors.red),
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
                          controller: _CategoriesController,
                          decoration:
                              const InputDecoration(labelText: 'Categories'),
                        ),
                        Text(
                          _errorMessages[1],
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    isActive: _currentStep == 1,
                  ),
                  Step(
                    title: const Text('Step 3'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          obscureText: true,
                        ),
                        Text(
                          _errorMessages[2],
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    isActive: _currentStep == 2,
                  ),
                  Step(
                    title: const Text('Step 4'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _phonenumberController,
                          decoration:
                              const InputDecoration(labelText: 'Phoner Number'),
                          obscureText: true,
                        ),
                        Text(
                          _errorMessages[3],
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    isActive: _currentStep == 3,
                  ),
                  Step(
                    title: const Text('Step 5'),
                    content: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Pick Image'),
                        ),
                        _selectedImage != null
                            ? Image.file(_selectedImage!)
                            : const SizedBox(),
                      ],
                    ),
                    isActive: _currentStep == 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _isSubmitting
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _currentStep > 0
                      ? () {
                          setState(() {
                            _currentStep -= 1;
                          });
                        }
                      : null,
                  child: const Text('Back'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_currentStep == 4) {
                      _submitForm();
                    } else {
                      setState(() {
                        _errorMessages[_currentStep] = '';
                        _currentStep += 1;
                      });
                    }
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _resetForm,
                  child: const Text('Reset'),
                ),
              ],
            ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

 void _submitForm() async {
  setState(() {
    _isSubmitting = true;
  });

  String name = _ShopNameController.text;
  String email = _emailController.text;
  String phonenumber = _phonenumberController.text;
  String categories = _CategoriesController.text;
  String base64Image = _selectedImage != null
      ? base64Encode(await _selectedImage!.readAsBytes())
      : '';

  try {
    var res = await http.post(
      Uri.parse('http://192.168.1.27/RUPIYOSELLER_API/save_seller_details.php'),
      body: {
        'ShopName': name,
        'Email_ID': email,
        'PhoneNumber': phonenumber,
        'Photos': base64Image,
        'Categories': categories,
      },
    );

    if (res.statusCode == 200) {
      if (res.headers['content-type']?.contains('application/json') ?? false) {
        var response = res.body.isNotEmpty ? jsonDecode(res.body) : null;

        if (response != null && response["success"] == true) {
          // Clear text fields
          _ShopNameController.clear();
          _emailController.clear();
          _phonenumberController.clear();
          _CategoriesController.clear();
          print('Record Inserted');
          print('Form submitted successfully');
        } else {
          print('Failed to submit form. Server response: ${res.body}');
        }
      } else {
        print('Unexpected content type. Server response: ${res.body}');
      }
    } else {
      print('HTTP request failed with status code: ${res.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    setState(() {
      _isSubmitting = false;
    });
  }
}
  void _resetForm() {
    _ShopNameController.clear();
    _emailController.clear();
    _phonenumberController.clear();
    _CategoriesController.clear();
    _selectedImage = null;
    _errorMessages = ['', '', '', '', ''];

    setState(() {
      _currentStep = 0;
    });
  }
}
