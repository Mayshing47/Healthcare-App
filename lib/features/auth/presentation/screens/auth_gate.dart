import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:health_care_application/features/auth/presentation/screens/sign_in_and_sign_up.dart';
import 'package:health_care_application/tabs.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData) {
        return Tabs();
      } else {
        return SignInAndSignUp();
      }
    });
  }
}
