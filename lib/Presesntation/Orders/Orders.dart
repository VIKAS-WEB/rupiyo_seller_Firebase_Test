import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/Widgets/NoData.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              NoDataFound(),
            ],
          ),
        ],
      ),
    );
  }
}
