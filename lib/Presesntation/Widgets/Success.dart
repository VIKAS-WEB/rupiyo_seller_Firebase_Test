import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('Assets/LottieAssets/Success.json',
                width: 100, height: 100),
            const SizedBox(height: 20),
            const Text('OTP Sent Successfully', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
