import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  // create new user using email and password
  static Future registerUser(String email, String password) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // create user records in user table
  static Future addUser(Map<String, dynamic> userData, id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userData);
  }

  // get student records from db
  static Future getStudents() async {
    QuerySnapshot students =
        await FirebaseFirestore.instance.collection('students').get();
    return students;
  }

  // get user record using mobile no
  static Future getUserById(mobile) async {
    QuerySnapshot user = await FirebaseFirestore.instance
        .collection('User')
        .where('mobileno', isEqualTo: mobile)
        .get();

    return user;
  }

  // login user using email and password
  static Future loginUser(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // logout user
  static Future signoutUser() async {
    return await FirebaseAuth.instance.signOut();
  }
}
