import 'dart:convert';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController BankName = TextEditingController();
  TextEditingController IFSC_CODE = TextEditingController();
  TextEditingController Account_Holder_Name = TextEditingController();
  TextEditingController AccountNumber = TextEditingController();

  Future<void> insertRecord() async {
    String uri = "http://192.168.1.48/RUPIYOSELLER_API/insert_record.php";

    try {
      var res = await http.post(Uri.parse(uri), 
      body: {
        "BankName": BankName.text,
        "IFSC_CODE": IFSC_CODE.text,
        "Account_Holder_Name": Account_Holder_Name.text,
        "AccountNumber": AccountNumber.text,
      });

      var response = res.body.isNotEmpty ? jsonDecode(res.body) : null;

      if (response["success"] == true) {
        _showSuccessDialog();

        // Clear text fields
        BankName.clear();
        IFSC_CODE.clear();
        Account_Holder_Name.clear();
        AccountNumber.clear();
        print('Record Inserted');
      } else {
        print(res.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: AppColor.BackgroundColor,
          ),
        ),
        title: const Text(
          'Bank Details',
          style: TextStyle(color: AppColor.BackgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Please Fill Bank Details',
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.0,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Bank Name',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Assets/Fonts/Poppins-Bold.ttf'),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 45,
                        width: 355,
                        child: TextFormField(
                          controller: BankName,
                          decoration: InputDecoration(
                            fillColor: AppColor.mainColor,
                            hintText: 'Enter Bank Name',
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter IFSC code',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Assets/Fonts/Poppins-Bold.ttf'),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 45,
                        width: 355,
                        child: TextFormField(
                          controller: IFSC_CODE,
                          decoration: InputDecoration(
                            fillColor: AppColor.mainColor,
                            hintText: 'HDFC0000043',
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Accound Holder name',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Assets/Fonts/Poppins-Bold.ttf'),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 45,
                        width: 355,
                        child: TextFormField(
                          controller: Account_Holder_Name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: AppColor.mainColor,
                            hintText: 'Account Holder Name',
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Account Number',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Assets/Fonts/Poppins-Bold.ttf'),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 45,
                        width: 355,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: AccountNumber,
                          decoration: InputDecoration(
                            fillColor: AppColor.mainColor,
                            hintText: 'XXXXXXX0980',
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EasyButton(
                    idleStateWidget: const Text(
                      'Add Details',
                      style: TextStyle(
                        color: AppColor.BackgroundColor,
                        fontSize: 15,
                      ),
                    ),
                    loadingStateWidget: const CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                    useWidthAnimation: true,
                    useEqualLoadingStateWidgetDimension: true,
                    width: 150.0,
                    height: 40.0,
                    borderRadius: 4.0,
                    contentGap: 6.0,
                    buttonColor: AppColor.mainColor,
                    onPressed: () {
                      insertRecord();
                      _showSuccessDialog();
                    },
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  // Function to show success dialogue box
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColor.BackgroundColor,
          content: Container(
            color: AppColor.BackgroundColor,
            height: 350,
            child: Column(
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Bank Details Successfully Added.',
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
                EasyButton(
                  idleStateWidget: const Text(
                    'Go To HomePage',
                    style: TextStyle(
                      color: AppColor.BackgroundColor,
                      fontSize: 15,
                    ),
                  ),
                  loadingStateWidget: const CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                  useWidthAnimation: true,
                  useEqualLoadingStateWidgetDimension: true,
                  width: 150.0,
                  height: 40.0,
                  borderRadius: 4.0,
                  contentGap: 6.0,
                  buttonColor: AppColor.mainColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ));
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //   SpinKitThreeBounce(
                //     color: Colors.green,
                //     size: 30,
                //   ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
