

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:health_care_application/utils/utils.dart';

class AuthExceptions {

  static void handleAuthException(FirebaseAuthException e) {
    if(kDebugMode) print('Firebase Auth Exception: ${e.code} - ${e.message}');

    switch(e.code) {
      case 'invalid-email':
        Utils.showSnackBar('Email is not valid');
        break;
      case 'email-already-in-use':
        Utils.showSnackBar('Email is already in use');
        break;
      case 'wrong-password':
        Utils.showSnackBar('Wrong password');
        break;
      case 'user-not-found':
        Utils.showSnackBar('User not found');
        break;
      case 'user-disabled':
        Utils.showSnackBar('User disabled');
        break;
      case 'weak-password':
        Utils.showSnackBar('Password is too weak');
        break;
      default:
        Utils.showSnackBar('An error occurred during authentication');
    }
  }

  static void handleGoogleAuthException(Exception e) {
    if(kDebugMode) print('Google Auth Exception: $e');
    Utils.showSnackBar('An error occurred during authentication');
  }

  static void handleEmailVerificationException(Object e) {
    if(kDebugMode) print('Email Verification Exception: $e');
    Utils.showSnackBar('An error occurred during email verification');
  }

  static void handleSignOutException(Object e) {
    if(kDebugMode) print('Sign Out Exception: $e');
    Utils.showSnackBar('An error occurred during sign out');
  }

  static void handleForgotPasswordException(Object e) {
    if(kDebugMode) print('Forgot Password Exception: $e');
    Utils.showSnackBar('An error occurred during forgot password');
  }

  static void handleGenericException(Object e) {
    if(kDebugMode) print('Generic Exception: $e');
    Utils.showSnackBar('An error occurred');
  }

  static void handleFormatException(FormatException e) {
    if(kDebugMode) print('FormatException:- ${e.toString()}');
    Utils.showSnackBar(e.toString());
  }
}