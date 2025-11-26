import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_application/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:health_care_application/features/auth/data/models/end_user.dart';
import 'package:health_care_application/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<User?> signUpWithEmail(EndUser endUser, String password) async {
    return await authRemoteDataSource.signUpWithEmail(
      endUser: endUser,
      password: password,
    );
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    return await authRemoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await authRemoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<void> sendEmailVerification() async {
    await authRemoteDataSource.sendEmailVerification();
  }

  @override
  Future<User?> signInWithGoogle() async {
   return await authRemoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await authRemoteDataSource.signOut();
  }
}
