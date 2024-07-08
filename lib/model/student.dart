import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String studentName;
  String rollNumber;
  String department;
  String address;
  String mailId;

  // Constructor to initialize the class with JSON data
  StudentModel({
    required this.studentName,
    required this.rollNumber,
    required this.department,
    required this.address,
    required this.mailId,
  });

  // Named constructor to convert JSON into a Student object
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentName: json['student_name'],
      rollNumber: json['roll_number'],
      department: json['department'],
      address: json['address'],
      mailId: json['mail_id'],
    );
  }

  // Method to convert Student object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'roll_number': rollNumber,
      'department': department,
      'address': address,
      'mail_id': mailId,
    };
  }

  // Convert Firestore DocumentSnapshot to Student object
  factory StudentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return StudentModel(
      studentName: data['student_name'],
      rollNumber: data['roll_number'],
      department: data['department'],
      address: data['address'],
      mailId: data['mail_id'],
    );
  }
}
