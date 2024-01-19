import 'package:flutter/material.dart';
import 'package:rupiyo_seller/CountryCode.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class pn extends StatelessWidget {
  final String countryCode;
  final TextEditingController phoneNumberController;
  final Function(String) onPhoneNumberChanged;
  pn({
    super.key,
    required this.countryCode,
    required this.phoneNumberController,
    required this.onPhoneNumberChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController phn = TextEditingController();
    String CountryCode = '+91';
    String CompleteNumber = '$phn$CountryCode';
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              child: Container(
                width: 55,
                decoration: const BoxDecoration(
                    color: AppColor.BackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Image(
                            image: AssetImage('Assets/Images/flag.png'),
                            fit: BoxFit.contain),
                      )
                      // Text(
                      //   '$CountryCode',
                      //   style: const TextStyle(
                      //       color: AppColor.BackgroundColor, fontSize: 20),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColor.BackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: 250,
                  height: 42,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    onChanged: onPhoneNumberChanged,
                    decoration: const InputDecoration(
                        hintTextDirection: TextDirection.ltr,
                        hintText: 'Enter Phone Number',
                        hintStyle: TextStyle( fontSize: 13,),
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10)
                        //border: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
