import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ValidationTest extends StatefulWidget {
  @override
  _ValidationTestState createState() => _ValidationTestState();
}

class _ValidationTestState extends State<ValidationTest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber? number; // Make PhoneNumber nullable
  bool isPhoneNumberEntered = false;

  String? validatePhoneNumber(String value) {
    if (!isPhoneNumberEntered) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPhoneNumberEntered &&
                            (number?.phoneNumber?.length ?? 0) > 10
                        ? Colors.red
                        : Colors.grey,
                  ),
                  child: const Center(
                    child: Text(
                      'Circle',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber? number) {
                    setState(() {
                      isPhoneNumberEntered = number?.phoneNumber != null &&
                          number!.phoneNumber!.isNotEmpty;
                      this.number = number;
                    });
                  },
                  initialValue: number,
                  onInputValidated: (bool value) {
                  // Validation logic if needed
                  },
                  selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
                  inputDecoration: const InputDecoration(
                  labelText: 'Enter Phone Number',
                  ),
                ),
                ElevatedButton(
                  onPressed: isPhoneNumberEntered &&
                          (number?.phoneNumber?.length ?? 0) > 6
                      ? () {
                          // Your logic for moving to the next page
                        }
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
