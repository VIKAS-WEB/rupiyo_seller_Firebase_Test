import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Presesntation/Orders/Orders.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),
    const Orders(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(  
            icon: Icon(CupertinoIcons.cube_box_fill),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
