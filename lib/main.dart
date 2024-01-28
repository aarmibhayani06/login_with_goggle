import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_with_goggle/Services_auth/Auth_service.dart';
import 'package:provider/provider.dart';
import 'Services_auth/auth_get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyAUwV2EID8z9wf1xL906RDHHE3GFyLLmj8',
        appId:'43141108522',
        messagingSenderId: '',
        projectId: 'goggle-login-a34e9')
  );
  runApp(
     ChangeNotifierProvider(create: (context)=>AuthService(),
     child: MyApp(),
     ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authgate(),
    );
  }
}

