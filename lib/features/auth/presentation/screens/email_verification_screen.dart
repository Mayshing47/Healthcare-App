import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/presentation/widgets/custom_button.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../tabs.dart';
import '../providers/authentication_provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!_isEmailVerified) {
      _sendEmailVerification();
      timer = Timer.periodic(Duration(milliseconds: 3000), (_) {
        _checkEmailVerified();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void _sendEmailVerification() async {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    await authProvider.sendEmailVerification();
  }

  void _checkEmailVerified() async {
    FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(_isEmailVerified) {
      timer?.cancel();
    }
  }
  
  void _onResendEmailTap() {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.sendEmailVerification();
  }
  
  void _onCancelTap() {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    Utils.showCircularProgressIndicator(context);
    authProvider.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return _isEmailVerified ? Tabs() : Scaffold(body: _buildBody());
  }
  
  Widget _buildBody() {
    final screenHeight = Utils.getScreenHeight(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildResendEmailButton(),
            SizedBox(height: screenHeight * 0.02),
            _buildCancelButton(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResendEmailButton() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        return CustomButton(
          onTap: _onResendEmailTap,
          child:
          provider.isLoading
              ? CircularProgressIndicator()
              : Text(
            'Resend Email',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildCancelButton() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        return CustomButton(
          onTap: _onCancelTap,
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isDarkTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
}
