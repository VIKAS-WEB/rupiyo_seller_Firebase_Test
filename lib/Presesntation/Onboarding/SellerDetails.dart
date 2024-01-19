import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/Stepper.dart';

class StoreBasicDetails extends StatefulWidget {
  const StoreBasicDetails({super.key});

  @override
  State<StoreBasicDetails> createState() => _StoreBasicDetailsState();
}

class _StoreBasicDetailsState extends State<StoreBasicDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Container(
                  //     height: 100,
                  //     width: 123,
                  //     child: const DecoratedBox(
                  //         decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage('Assets/Images/rp.png'),
                  //                 fit: BoxFit.contain)))),
                ],
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lets Start Creating Your Shop',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Add Name and Link to Your Shop',
                          style: TextStyle(
                              fontSize: 14, color: AppColor.textColor2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(flex: 2, child: StepperDetails())
            ],
          ),
        ),
      ),
    );
  }
}
