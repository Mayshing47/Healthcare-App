import 'package:flutter/material.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/features/auth/domain/repository/auth_repository.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AuthenticationProvider({required this.authRepository});

  Future<void> signUpWithEmail({
    required EndUser endUser,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    await authRepository.signUpWithEmail(endUser, password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    await authRepository.signInWithEmail(email, password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> forgotPassword({required String email}) async {
    _isLoading = true;
    notifyListeners();
    await authRepository.forgotPassword(email);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    _isLoading = true;
    notifyListeners();
    await authRepository.sendEmailVerification();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    await authRepository.signOut();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    await authRepository.signInWithGoogle();
    _isLoading = false;
    notifyListeners();
  }
}
