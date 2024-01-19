import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl =
      "http://192.168.1.2/RUPIYOSELLER_API/getImage.php"; // Replace with your PHP backend URL

  Future<void> fetchImage() async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final String base64Image = json.decode(response.body)['image'];

        setState(() {
          imageUrl = base64Image;
        });
      } else {
        throw Exception('Failed to load image');
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0XFFEFE5E5),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back)),
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.only(top: 65, left: 60),
                          child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              child: Icon(
                                CupertinoIcons.pencil_circle_fill,
                                color: Colors.grey,
                                size: 40,
                              )),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 54,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Seller Name',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Seller@gmail.com',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 40),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.bag,
                        color: Color(0XFFDF2C25),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Orders'),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.forward,
                            color: Color(0XFFDF2C25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), //Order Row.
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_2,
                          color: Color(0XFFDF2C25),
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Customer Support & FAQ',
                          maxLines: 2,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.forward,
                              color: Color(0XFFDF2C25),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ), //Customer Support Row.
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.placemark,
                        color: Color(0XFFDF2C25),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Edit Address'),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.forward,
                            color: Color(0XFFDF2C25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_2,
                          color: Color(0XFFDF2C25),
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Personal Details',
                          maxLines: 2,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.forward,
                              color: Color(0XFFDF2C25),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.cube_box,
                          color: Color(0XFFDF2C25),
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Prdoduct Listings',
                          maxLines: 2,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.forward,
                              color: Color(0XFFDF2C25),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                // SizedBox(
                //   height: 48,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: Text(
                //       'Select Store Type',
                //       style: TextStyle(fontSize: 16),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
