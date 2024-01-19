import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/BankDetails.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Drawer/DrawerList.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Email%20Verfication.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Profile.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/SalesSummary.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/StoreDetails.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/SellerDetails.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OrdersPage.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SelectSubscription.dart';
import 'package:http/http.dart' as http;
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/Login.dart';

class UserDashboard extends StatefulWidget {
  final Map<String, dynamic> userData;

  UserDashboard({super.key, required this.userData});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final GlobalKey<RefreshIndicatorState> _refreshindicatorkey =
      GlobalKey<RefreshIndicatorState>();

  // void initState() {
  //   super.initState();
  //   // Set the message when the page is loaded
  //   _loadUserData('8755228885');
  // }

  // Future<void> _loadUserData(String phoneNumber) async {
  //   try {
  //     // Simulate successful API call
  //     final response = await http.get(Uri.parse(
  //         'http://192.168.1.41/RUPIYOSELLER_API/getUser.php?phone_number=$phoneNumber'));

  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     } else {
  //       print('Error loading user data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error loading user data: $e');
  //   }
  // }

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
                'You Have Not Selected Any\nStore Type.'),
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

  // Add a method for the refresh action
  Future<void> _onRefresh() async {
    // Implement the logic to refresh data here
    // For example, you can make an API call or update data
    await Future.delayed(Duration(seconds: 1));

    // After refreshing, you can setState to update the UI if needed

    // If you don't need to update the UI, you can simply return a Future.value()
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    void _logout() {
      // Clear any user authentication tokens or relevant data
      // ...

      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0XFFEFE5E5),
      body: RefreshIndicator(
        key: _refreshindicatorkey,
        onRefresh: _onRefresh,
        child: Builder(
          builder: (context) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              //color: AppColor.BackgroundColor,
                              blurRadius: 3)
                        ],
                        color: AppColor.mainColor,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(80))),
                    height: MediaQuery.sizeOf(context).height / 2.2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: const Icon(
                                    CupertinoIcons.text_justify,
                                    color: AppColor.BackgroundColor,
                                    size: 32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Profile(),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35,
                                      backgroundImage: AssetImage(
                                          'Assets/Images/profile.jpg'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hello, ${widget.userData['username']}!',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: AppColor.BackgroundColor,
                                        fontFamily:
                                            'Assets/Fonts/Poppins-Bold.ttf'),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 40,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Today Sales',
                                          style: TextStyle(
                                              color: AppColor.BackgroundColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹ 0.00',
                                          style: TextStyle(
                                              fontSize: 36,
                                              color: AppColor.BackgroundColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BankDetails(),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                shadowColor: AppColor.BackgroundColor,
                                color: AppColor.BackgroundColor,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  width: 165,
                                  height: 178,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 32,
                                              backgroundImage: AssetImage(
                                                  'Assets/Images/bank.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'Bank Details',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: AppColor.textColor),
                                              ),
                                            ),
                                            Icon(
                                              CupertinoIcons.arrow_right,
                                              color: AppColor.textColor,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColor.textColor,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'NOT PROVIDED',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Assets/Fonts/Poppins-Bold.ttf',
                                                      color: AppColor
                                                          .BackgroundColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailVerfication(),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                shadowColor: AppColor.textColor2,
                                color: AppColor.BackgroundColor,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  width: 165,
                                  height: 178,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColor.mainColor,
                                              maxRadius: 32,
                                              child: Icon(
                                                CupertinoIcons.mail_solid,
                                                color: AppColor.BackgroundColor,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColor.textColor),
                                            ),
                                            Icon(
                                              CupertinoIcons.arrow_right,
                                              color: AppColor.textColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.yellow[800]),
                                            child: const Center(
                                              child: Text(
                                                'Verification Pending',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Assets/Fonts/Poppins-Bold.ttf',
                                                    color: AppColor
                                                        .BackgroundColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BankDetails(),
                                  ),
                                );
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StoreDetailsForm(),
                                      ));
                                },
                                child: Card(
                                  elevation: 0,
                                  shadowColor: AppColor.BackgroundColor,
                                  color: AppColor.BackgroundColor,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    width: 165,
                                    height: 178,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColor.mainColor,
                                                maxRadius: 32,
                                                child: Icon(
                                                  CupertinoIcons.doc_chart_fill,
                                                  color:
                                                      AppColor.BackgroundColor,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Store Details',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color:
                                                          AppColor.textColor),
                                                ),
                                              ),
                                              Icon(
                                                CupertinoIcons.arrow_right,
                                                color: AppColor.textColor,
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColor.textColor,
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'NOT PROVIDED',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Assets/Fonts/Poppins-Bold.ttf',
                                                        color: AppColor
                                                            .BackgroundColor),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            //   InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               const EmailVerfication(),
                            //         ),
                            //       );
                            //     },
                            //     child: Card(
                            //       elevation: 0,
                            //       shadowColor: AppColor.textColor2,
                            //       color: AppColor.BackgroundColor,
                            //       child: Container(
                            //         decoration:
                            //             const BoxDecoration(shape: BoxShape.circle),
                            //         width: 165,
                            //         height: 178,
                            //         child: Column(
                            //           children: [
                            //             const Padding(
                            //               padding: EdgeInsets.symmetric(
                            //                   horizontal: 15, vertical: 15),
                            //               child: Row(
                            //                 children: [
                            //                   CircleAvatar(
                            //                     backgroundColor: AppColor.mainColor,
                            //                     maxRadius: 32,
                            //                     child: Icon(
                            //                       CupertinoIcons.mail_solid,
                            //                       color: AppColor.BackgroundColor,
                            //                       size: 30,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               height: 10,
                            //             ),
                            //             const Padding(
                            //               padding:
                            //                   EdgeInsets.symmetric(horizontal: 15),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     'Email',
                            //                     style: TextStyle(
                            //                         fontSize: 17,
                            //                         color: AppColor.textColor),
                            //                   ),
                            //                   Icon(
                            //                     CupertinoIcons.arrow_right,
                            //                     color: AppColor.textColor,
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               height: 10,
                            //             ),
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 Container(
                            //                   width: 150,
                            //                   height: 25,
                            //                   decoration: BoxDecoration(
                            //                       borderRadius:
                            //                           BorderRadius.circular(10),
                            //                       color: Colors.yellow[800]),
                            //                   child: const Center(
                            //                     child: Text(
                            //                       'Verification Pending',
                            //                       style: TextStyle(
                            //                           fontFamily:
                            //                               'Assets/Fonts/Poppins-Bold.ttf',
                            //                           color:
                            //                               AppColor.BackgroundColor),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ],
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.BackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColor.mainColor,
            ),
            child: SizedBox(
              height: 50,
              width: 20,
              child: Image.asset(
                'Assets/Images/Rlogo.png',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 30,
            ),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle the tap on Home
              Navigator.pop(context); // Close the drawer
            },
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ));
            },
            child: const ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Icon(
              Icons.account_balance_sharp,
              size: 30,
            ),
            title: const Text(
              'Balance  ',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle the tap on Settings
              Navigator.pop(context); // Close the drawer
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.cube_box_fill,
              size: 30,
            ),
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle the tap on Settings
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 200),
                  type: PageTransitionType.leftToRight,
                  child: const OrdersPage(),
                ),
              ); // Close the drawer
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: AppColor.BackgroundColor),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                  text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Powered By',
                      style: TextStyle(color: AppColor.textColor)),
                  TextSpan(
                      text: ' Crewman Solutions Pvt Ltd.',
                      style: TextStyle(color: AppColor.mainColor)),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}

