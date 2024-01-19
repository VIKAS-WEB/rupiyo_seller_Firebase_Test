import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/TrialDashboard.dart';

class SelectSubscription extends StatefulWidget {
  const SelectSubscription({super.key});

  @override
  State<SelectSubscription> createState() => _SelectSubscriptionState();
}

class _SelectSubscriptionState extends State<SelectSubscription> {
  @override
  Widget build(BuildContext context) {
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
              icon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColor.textColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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

    void _showStoreDialog(String storeType, String Listing) {
      showDialog(
        barrierColor: Colors.black54,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 9,
            shadowColor: AppColor.textColor,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'You Have Selected\n$storeType,\nBasic Feature Of $storeType Is You Have A Limit\nof $Listing Product Listings\nYou Can Change Your Store Type In Future\nAccroding To Your Need.',
                          style: const TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 0.1,
                              wordSpacing: 1.6),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10)))),
                                  onPressed: () {
                                    print('$storeType Selected');
                                  },
                                  child: const Text(
                                    'Enroll Now',
                                    style: TextStyle(
                                        color: AppColor.BackgroundColor),
                                  )),
                            ),
                            //Text('Buy Now'),
                            Container(
                              width: 50,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor
                                    .BackgroundColor, // Button background color
                              ),
                              child: Lottie.asset(
                                'Assets/LottieAssets/RightArrow.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(60),
                  //     bottomRight: Radius.circular(60)),
                  //     gradient: LinearGradient(colors: [
                  //     Color.fromARGB(255, 223, 10, 45),
                  //     Color.fromARGB(255, 254, 254, 254),
                  // ])),
                  image: DecorationImage(
                      image: AssetImage('Assets/Images/b.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Store Type',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome to the Rupiyo App\nwhere your preferences reign supreme! \nWith our "Choose Your Store Type" feature',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _showStoreDialog('Micro Store', '50'),
                      child: Card(
                        elevation: 8,
                        color: AppColor.mainColor,
                        child: Container(
                          height: 60,
                          width: 150,
                          child: const Center(
                            child: Text(
                              'Micro Store',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.BackgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showStoreDialog('Mini Store', '100'),
                      child: Card(
                        elevation: 8,
                        color: AppColor.mainColor,
                        child: SizedBox(
                          height: 60,
                          width: 150,
                          child: const Center(
                            child: Text(
                              'Mini Store',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.BackgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _showStoreDialog('Mega Store', '400'),
                      child: Card(
                        elevation: 8,
                        color: AppColor.mainColor,
                        child: Container(
                          height: 60,
                          width: 150,
                          child: const Center(
                            child: Text(
                              'Mega Store',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.BackgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showStoreDialog('Super Store', '200'),
                      child: Card(
                        elevation: 8,
                        color: AppColor.mainColor,
                        child: Container(
                          height: 60,
                          width: 150,
                          child: const Center(
                            child: Text(
                              'Super Store',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.BackgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height / 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrialDashboard(),
                        ));
                  },
                  child: GestureDetector(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              color: AppColor.mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.BackgroundColor,
        elevation: 0,
        title: const Text(
          'Alert',
          textAlign: TextAlign.center,
        ),
        content: const Text(
            textAlign: TextAlign.center,
            'Are You Sure,\nIf You Did Not Select Any Store Type You Might Not Be Able To List Your Products'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Request notification permission
              await requestNotificationPermission();

              // Get FCM token
              String? fcmToken = await FirebaseMessaging.instance.getToken();

              // Send welcome notification
              if (fcmToken != null) {
                await sendWelcomeNotification(fcmToken);
              }

              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrialDashboard(),
                  ));
            },
            child: const Text('Proceed'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }
}

Future<void> sendWelcomeNotification(String token) async {
  try {
    await FirebaseMessaging.instance.subscribeToTopic('welcome_notifications');
    print('Welcome notification sent successfully');
  } catch (error) {
    print('Failed to send welcome notification: $error');
  }
}
