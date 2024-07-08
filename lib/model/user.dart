import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstName;
  String lastName;
  String email;
  String mobileNo;
  String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNo': mobileNo,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      password: json['password'],
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      mobileNo: data['mobileno'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
