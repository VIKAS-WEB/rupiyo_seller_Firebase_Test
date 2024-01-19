import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BackgroundColor,
      appBar: AppBar(
      backgroundColor: AppColor.mainColor,
      leading: InkWell(
       onTap: () =>  Navigator.pop(context),
        child: Icon(CupertinoIcons.back, color: AppColor.BackgroundColor, size: 30,)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/Images/EmptyList.jpg'), opacity: 8,fit: BoxFit.contain))),
            ),
            Text('No Orders', style: TextStyle(fontSize: 25, color: AppColor.textColor),)
          ],
        ),
      ),
    );
  }
}