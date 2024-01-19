import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
      ),
      drawer: const Drawer(
        
        elevation: 0,
        backgroundColor: AppColor.BackgroundColor,
      ),
    );
  }
}
