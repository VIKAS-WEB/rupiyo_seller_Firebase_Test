import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  List<IconData> _icons = [Icons.home, Icons.work, Icons.person];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicator Demo'),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildBottomBarIcons(),
              ),
            ),
            InkWell(
              onTap: () {
                _changePage;
              },
              child: Container(
                width: 89,
                height: 70,
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        offset: Offset(0.9, 0.5),
                        color: AppColor.textColor2,
                      ),
                    ]),
                child: const Icon(
                  CupertinoIcons.arrow_right,
                  color: AppColor.BackgroundColor,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          buildPage(Colors.red, "Page 1"),
          buildPage(Colors.blue, "Page 2"),
          buildPage(Colors.green, "Page 3"),
        ],
      ),
    );
  }

  Widget buildPage(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 36.0,
              child: Icon(
                _icons[_currentPage],
                color: Colors.black,
                size: 36.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Reset to the first page
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<Widget> _buildBottomBarIcons() {
    List<Widget> icons = [];

    for (int i = 0; i < 3; i++) {
      icons.add(_buildBottomBarIcon(i == _currentPage, _icons[i]));
    }

    return icons;
  }

  Widget _buildBottomBarIcon(bool isActive, IconData icon) {
    return IconButton(
      onPressed: () {
        _pageController.animateToPage(
          _icons.indexOf(icon),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      icon: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey,
        size: 32.0,
      ),
    );
  }
}
