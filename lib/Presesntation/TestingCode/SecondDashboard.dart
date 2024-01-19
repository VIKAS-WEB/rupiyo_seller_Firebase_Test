import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SelectSubscription.dart';

class SecondDashboard extends StatefulWidget {
  @override
  _SecondDashboardState createState() => _SecondDashboardState();
}

class _SecondDashboardState extends State<SecondDashboard> {
  //String message = 'Welcome to the Second Home Page!';

  @override
  void initState() {
    super.initState();
    // Set the message when the page is loaded
    setMessageOnLoad();
  }

  void setMessageOnLoad() {
    // You can set any message you want here
    // For example, you can fetch data from an API or perform any other logic
    // Here, we are just setting a static message
    Future.delayed(Duration.zero, () {
      // Show a dialog when the page is loaded
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: AppColor.BackgroundColor,
            title: const Text(
              textAlign: TextAlign.center,
              "Welcome",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            content: const Text(
                textAlign: TextAlign.center,
                'You Have Not Select Any\nStore Type.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectSubscription(),
                      ));
                },
                child: const Center(
                    child: Text("Go To The Store Selection Page.")),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'DASHBOARD',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
