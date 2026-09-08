import 'package:cropdisease/loginpage.dart';
import 'package:cropdisease/main_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authwrapper extends StatefulWidget {
  const Authwrapper({super.key});

  @override
  State<Authwrapper> createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: CircularProgressIndicator(strokeWidth: 5));
        }
        if (snapshot.hasData) {
          return const MainNavigation();
        }
        return Loginpage();
      },
    );
  }
}
