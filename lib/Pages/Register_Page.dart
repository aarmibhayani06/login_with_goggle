import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Button.dart';

import '../Services_auth/Auth_service.dart';
import '../text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text("Password do not match")));
      return;
    }
    final authService = Provider.of<AuthService>(context,listen: false);
    try
      {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text
      );
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              e.toString()),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Icon(
              Icons.message,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 50),
            Text(
              "Let's create an account for you",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            MyTxtfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false),
            SizedBox(height: 10),
            MyTxtfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false),
            SizedBox(height: 25),
            MyTxtfield(
                controller: confirmController,
                hintText: 'Confirm Password',
                obscureText: false),
            SizedBox(height: 25),
            Button(onTap: signUp, text: 'Sign up'),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a Member?'),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
