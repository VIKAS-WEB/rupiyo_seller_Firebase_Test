import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My widget')),
      body: SafeArea(child: Column(
        children: [
          Row(
            children: [
              Image.asset('Assets/Images/NoData.jpg')
            ],
          )
        ],
      )),
    );
  }
}
