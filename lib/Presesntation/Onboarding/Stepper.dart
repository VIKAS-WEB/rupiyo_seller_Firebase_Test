import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class StepperDetails extends StatefulWidget {
  const StepperDetails({super.key});

  @override
  State<StepperDetails> createState() => _StepperDetailsState();
}

class _StepperDetailsState extends State<StepperDetails> {
  int activeStep = 5; // Initial step set to 5.

  int upperBound = 6;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: Column(
        children: [
          IconStepper(
            steppingEnabled: true,
            activeStepColor: AppColor.mainColor,
            activeStepBorderColor: AppColor.BackgroundColor,
            icons: const [
              Icon(
                Icons.shopping_bag_outlined,
                color: AppColor.BackgroundColor,
              ),
              Icon(
                Icons.border_all_outlined,
                color: AppColor.BackgroundColor,
              ),
              Icon(
                CupertinoIcons.creditcard_fill,
                color: AppColor.BackgroundColor,
              ),
              Icon(
                CupertinoIcons.cube_fill,
                color: AppColor.BackgroundColor,
              ),
              Icon(
                CupertinoIcons.photo,
                color: AppColor.BackgroundColor,
              ),
            ],

            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,

            // This ensures step-tapping updates the activeStep.
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          Expanded(flex: 2, child: ShopDetailsForm()),
          // Expanded(
          //   child: FittedBox(
          //     child: Center(
          //       child: Text('$activeStep'),
          //     ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // previousButton(),
              Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.bottomCenter, child: nextButton())),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 42,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.mainColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () {
              if (activeStep < upperBound) {
                setState(() {
                  activeStep++;
                });
              }
            },
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             const OtpVerification()));
            // setState(() {
            //   loading = true;
            // });
            // auth.verifyPhoneNumber(
            //     phoneNumber: phoneNumberController.text,
            //     verificationCompleted: (_) {
            //       setState(() {
            //         loading = false;
            //       });
            //       Utils().toastMessage('Otp Sent Successfully');
            //     },
            //     verificationFailed: (e) {
            //       Utils().toastMessage(e.toString());
            //       setState(() {
            //         loading = false;
            //       });
            //     },
            //     codeSent: (String verificationId, int? token) {
            //       setState(() {
            //         loading = false;
            //       });
            //       Navigator.push(
            //       context,
            //           MaterialPageRoute(
            //               builder: (context) => OtpVerification(
            //                     verificationId: verificationId,
            //                   )));
            //     },
            //     codeAutoRetrievalTimeout: (e) {
            //       setState(() {
            //         loading = false;
            //       });
            //       Utils().toastMessage(e.toString());
            //     });
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Shop Name';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}

class ShopDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Name Of Your Shop'),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            )
          ],
        )
      ],
    );
  }
}
