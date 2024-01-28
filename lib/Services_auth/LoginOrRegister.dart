import 'package:flutter/material.dart';
import 'package:login_with_goggle/Pages/LoginPage.dart';

import '../Pages/Register_Page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPAge =  true;

  void togglePages()
  {
    setState(() {
      showLoginPAge = !showLoginPAge;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPAge)
    {
      return LoginPage(onTap: togglePages);
    }
    else
      {
        return RegisterPage(onTap:togglePages);
      }


  }
}
