import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:health_care_application/features/auth/presentation/screens/sign_up_screen.dart';

class SignInAndSignUp extends StatefulWidget {
  const SignInAndSignUp({super.key});

  @override
  State<SignInAndSignUp> createState() => _SignInAndSignUpState();
}

class _SignInAndSignUpState extends State<SignInAndSignUp> {
  bool _isSignIn = true;

  void changeScreen() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return _isSignIn ? SignInScreen(onSignUpTap: changeScreen) : SignUpScreen(onSignInTap: changeScreen);
  }
}
