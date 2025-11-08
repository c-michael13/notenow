import 'package:firebase_auth/firebase_auth.dart';


class AuthResults {
  final bool success;
  final User? userID;
  final String? errorCode;
  final String? message;

  AuthResults({
    required this.success,
    this.userID,
    this.errorCode,
    this.message,
  });
}