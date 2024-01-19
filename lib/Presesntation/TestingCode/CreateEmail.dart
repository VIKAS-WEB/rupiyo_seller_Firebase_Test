import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnterEmailPage extends StatefulWidget {
  @override
  _EnterEmailPageState createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final _emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _sendVerificationEmail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final email = _emailController.text;
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: 'temporaryPassword123', // Replace with a secure password
      );
      await userCredential.user!.sendEmailVerification();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent!'),
        ),
      );

      // Navigate to another page or handle successful verification
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message}'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _sendVerificationEmail,
              child: Text(isLoading ? 'Sending...' : 'Verify Email'),
            ),
          ],
        ),
      ),
    );
  }
}
