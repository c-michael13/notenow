import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_now/model/data_model/auth_results.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  User? get currentUser => _auth.currentUser;

  // Create account with email and password
  Future<AuthResults> createAccount (
    {
      required String email, 
      required String password,
      String? username
    }
  ) async {

    try {
      
      final userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      // Update display name if username is provided
      if (username != null && userCredentials.user != null) {
        await userCredentials.user!.updateDisplayName(username);
        await userCredentials.user!.reload();
      }

      return AuthResults(
        success: true,
        userID: userCredentials.user,
        message: "Account created successfully",
      );

    } on FirebaseAuthException catch (e) {
      return AuthResults(
        success: false,
        errorCode: e.code,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResults(
        success: false,
        message: 'An unexpected error occurred: Please try again',
      );

    }
  }


  // Function for signin users
  Future<AuthResults> signinUser (
    {
      required String email,
      required String password,
    }
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );


      return AuthResults(
        success: true,
        userID: userCredential.user,
        message: 'Signed in successfully',
      );

    } on FirebaseAuthException catch (e) {
      return AuthResults(
        success: false,
        errorCode: e.code,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResults(
        success: false,
        message: 'An unexpected error occurred: Please try again',
      );
    }
  }

  Future<AuthResults> forgotPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return AuthResults(
        success: true,
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResults(
        success: false,
        errorCode: e.code,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResults(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }


  // Delete Account
  Future<AuthResults> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        return AuthResults(
          success: false,
          message: 'No user is currently signed in',
        );
      }

      await user.delete();

      return AuthResults(
        success: true,
        message: 'Account deleted successfully',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return AuthResults(
          success: false,
          errorCode: e.code,
          message: 'This operation requires recent authentication. Please sign in again and try.',
        );
      }
      return AuthResults(
        success: false,
        errorCode: e.code,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResults(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }


  // Sign Out
  Future<AuthResults> signOut() async {
    try {
      await _auth.signOut();
      return AuthResults(
        success: true,
        message: 'Signed out successfully',
      );
    } catch (e) {
      return AuthResults(
        success: false,
        message: 'Failed to sign out: ${e.toString()}',
      );
    }
  }

  // Helper method to get user-friendly error messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please sign in or use a different email.';
      case 'invalid-email':
        return 'The email address is not valid. Please check and try again.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No account found with this email. Please check or create a new account.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many unsuccessful attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(firebaseAuthProvider));
});


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});