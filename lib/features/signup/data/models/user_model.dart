import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? phoneNumber;
  final String? email;
  final String? displayName;

  UserModel({
    required this.uid,
    this.phoneNumber,
    this.email,
    this.displayName,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      email: user.email,
      displayName: user.displayName,
    );
  }
}