
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmail(EndUser endUser, String password);
  Future<User?> signInWithEmail(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> forgotPassword(String email);
  Future<void> sendEmailVerification();
  Future<void> signOut();
}