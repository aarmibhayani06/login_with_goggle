import 'package:flutter/material.dart';
import 'package:login_with_goggle/Services_auth/Auth_service.dart';
import 'package:login_with_goggle/text_field.dart';
import 'package:provider/provider.dart';
import '../Button.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,
    required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn()async
  {
    final authService = Provider.of<AuthService>(context,listen:false);
    try {
      await authService.signInWithEmailandPassword(
         emailController.text,
          passwordController.text
      );
    }catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:Text(
                  e.toString())));
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
            SizedBox(height: 20),
            Icon(
              Icons.message,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 50),
            Text(
              "Welcome to you\'ve been missed",
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
                obscureText: true),
            SizedBox(height: 25),
            Button(onTap:()
                {
                  signIn();
                //  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(),));
                },
                text: 'Sign in'),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a Member?'),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now',
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
