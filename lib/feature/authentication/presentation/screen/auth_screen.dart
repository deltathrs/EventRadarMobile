import 'package:event_radar2/feature/authentication/presentation/screen/login_or_register_screen.dart';
import 'package:event_radar2/feature/authentication/presentation/screen/login_screen.dart';
import 'package:event_radar2/navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user logged in
        if (snapshot.hasData) {
          return const NavigationPage();
        }

        //user NOT logged in
        else {
          return const LoginOrRegisterPage();
        }
      },
    ));
  }
}
