import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/BankDetails.dart';
//import 'package:rupiyo_seller/Presesntation/HomePage/Drawer/DrawerList.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Email%20Verfication.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Profile.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/SalesSummary.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEFE5E5),
      body: Builder(
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
                                        ));
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage('Assets/Images/profile.jpg'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hello Seller!',
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
                            padding: EdgeInsets.only(top: 40),
                            child: Row(
                              children: [
                                Text(
                                  'Today Sales',
                                  style: TextStyle(
                                      color: AppColor.BackgroundColor,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Text(
                                '₹ 1260.40',
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
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
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
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
                                            backgroundColor: AppColor.mainColor,
                                            maxRadius: 32,
                                            child: Icon(
                                              CupertinoIcons.house_fill,
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'POS',
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
                                                'Start Your Sale',
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
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
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
                                            backgroundColor: AppColor.mainColor,
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
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
                                                  color:
                                                      AppColor.BackgroundColor),
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
                                    builder: (context) => const SalesSummary(),
                                  ));
                            },
                            child: Card(
                              elevation: 0,
                              shadowColor: AppColor.BackgroundColor,
                              color: AppColor.BackgroundColor,
                              child: Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                width: 165,
                                height: 150,
                                child: const Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColor.mainColor,
                                            maxRadius: 32,
                                            child: Icon(
                                              CupertinoIcons.money_dollar,
                                              color: AppColor.BackgroundColor,
                                              size: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Sales Summary',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor.textColor),
                                        ),
                                        Icon(
                                          CupertinoIcons.arrow_right,
                                          color: AppColor.textColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Card(
                            elevation: 0,
                            shadowColor: AppColor.textColor2,
                            color: AppColor.BackgroundColor,
                            child: Container(
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              width: 165,
                              height: 150,
                              child: const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.mainColor,
                                          maxRadius: 32,
                                          child: Icon(
                                            CupertinoIcons.cube_box_fill,
                                            color: AppColor.BackgroundColor,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Products',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: AppColor.textColor),
                                      ),
                                      Icon(
                                        CupertinoIcons.arrow_right,
                                        color: AppColor.textColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
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
          ListTile(
            leading: const Icon(
              Icons.analytics_rounded,
              size: 30,
            ),
            title: const Text(
              'Total Sales',
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
              Icons.summarize_outlined,
              size: 30,
            ),
            title: const Text(
              'Sales Summary',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Handle the tap on Settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesSummary(),
                  )); // Close the drawer
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
                  MaterialPageRoute(
                    builder: (context) => const SalesSummary(),
                  )); // Close the drawer
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
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
                    onPressed: () {},
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
