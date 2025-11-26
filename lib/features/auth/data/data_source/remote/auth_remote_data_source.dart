import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_care_application/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:health_care_application/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:health_care_application/features/profile/domain/repository/profile_repository.dart';
import 'package:health_care_application/utils/utils.dart';

import '../../models/end_user.dart';

class AuthRemoteDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final ProfileRepository profileRepository;

  AuthRemoteDataSource({required this.profileRepository});

  Future<User?> signUpWithEmail({
    required EndUser endUser,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: endUser.email,
        password: password,
      );
      await profileRepository.saveUser(endUser, credential.user!.uid);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handleAuthException(e);
    } on FormatException catch (e) {
      AuthExceptions.handleFormatException(e);
    } catch (e) {
      AuthExceptions.handleGenericException(e);
    }
    return null;
  }

  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials.user;
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handleAuthException(e);
    } on FormatException catch (e) {
      AuthExceptions.handleFormatException(e);
    } catch (e) {
      AuthExceptions.handleGenericException(e);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handleSignOutException(e);
    } on FormatException catch (e) {
      AuthExceptions.handleFormatException(e);
    } catch (e) {
      AuthExceptions.handleSignOutException(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
      Utils.showSnackBar('Email verification has been sent');
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handleEmailVerificationException(e);
    } on FormatException catch (e) {
      AuthExceptions.handleFormatException(e);
    } catch (e) {
      AuthExceptions.handleEmailVerificationException(e);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Utils.showSnackBar('Password reset email has been sent');
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handleForgotPasswordException(e);
    } on FormatException catch (e) {
      AuthExceptions.handleFormatException(e);
    } catch (e) {
      AuthExceptions.handleForgotPasswordException(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // this opens the google sign in interface for user
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // this line indicates that the sign in process is not cancelled if its null then user cancelled the process
      if (googleUser != null) {
        // if user signs in successfully this method retrieves authentication details such ad accessToken and idToken
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);

        // create user
        final user = EndUser(
          id: userCredential.user!.uid,
          name: userCredential.user!.email.toString(),
          email: userCredential.user!.email.toString(),
          createdAt: DateTime.now(),
        );
        profileRepository.saveUser(user, userCredential.user!.uid);

        // this line will return user credentials
        return userCredential.user;
      } else {
        Utils.showSnackBar('Google sign-in cancelled');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    return null;
  }
}
