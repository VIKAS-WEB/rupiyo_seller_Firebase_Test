import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController _emailController = TextEditingController();
  bool _isValidEmail = false;
  bool _containerClicked = false;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(
                  () {
                    _currentPage = page;
                  },
                );
              },
              physics: (_isValidEmail && _containerClicked)
                  ? const NeverScrollableScrollPhysics() // Prevents scrolling back
                  : const AlwaysScrollableScrollPhysics(),
              children: [
                MyForm(
                  emailController: _emailController,
                  isValidEmail: _isValidEmail,
                  containerClicked: _containerClicked,
                  onEmailChanged: _handleEmailChanged,
                  onContainerClicked: _handleContainerClicked,
                ),
                Container(
                    color: Colors.blue,
                    child: const Center(child: Text('Page 2'))),
                Container(
                    color: Colors.green,
                    child: const Center(child: Text('Page 3'))),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  void _handleEmailChanged(String value, bool isValid) {
    setState(() {
      _isValidEmail = isValid;
    });
  }

  void _handleContainerClicked() {
    setState(() {
      _containerClicked = true;
    });

    if (_isValidEmail) {
      // Action to perform when the container is clicked
      print('Container clicked with email: ${_emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Container clicked with email: ${_emailController.text}'),
        ),
      );
      // You can add additional actions here

      // Move to the next page after clicking the container
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Widget _buildBottomBar() {
    return Container(
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => _buildDot(index),
        ),
      ),
    );
  }

  Widget _buildDot(int pageIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pageIndex == _currentPage ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  final TextEditingController emailController;
  final bool isValidEmail;
  final bool containerClicked;
  final Function(String, bool) onEmailChanged;
  final VoidCallback onContainerClicked;

  MyForm({
    required this.emailController,
    required this.isValidEmail,
    required this.containerClicked,
    required this.onEmailChanged,
    required this.onContainerClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Enter your email',
            ),
            onChanged: (value) {
              onEmailChanged(value, _isValidEmailAddress(value));
            },
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: isValidEmail ? onContainerClicked : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: isValidEmail ? Colors.blue : Colors.grey,
              child: isValidEmail
                  ? const Center(
                      child: Text(
                        'Clickable Container',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 36.0,
                    ),
            ),
          ),
          const SizedBox(height: 16.0),
          if (!isValidEmail)
            const Text(
              'Please enter a valid email address.',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  bool _isValidEmailAddress(String email) {
    // Use a regular expression to check if the email format is valid
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }
}
