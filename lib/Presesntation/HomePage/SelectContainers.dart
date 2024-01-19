import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class SelectBoxes extends StatefulWidget {
  const SelectBoxes({super.key});

  @override
  State<SelectBoxes> createState() => _SelectBoxesState();
}

class _SelectBoxesState extends State<SelectBoxes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                child: const Text(
                  'Choose Your Store Type',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                color: AppColor.mainColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
