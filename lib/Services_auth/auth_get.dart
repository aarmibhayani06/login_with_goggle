import 'package:flutter/material.dart';
import 'package:login_with_goggle/Services_auth/LoginOrRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Pages/HomePAge.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
            {
              return HomePage();
            }
          else
            {
              return LoginOrRegister();
            }
        },
      ),
    );
  }
}
