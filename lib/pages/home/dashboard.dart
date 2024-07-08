import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentms/components/ConfirmDialog.dart';
import 'package:studentms/model/student.dart';
import 'package:studentms/model/user.dart';
import 'package:studentms/services/api_service.dart';
import 'package:studentms/services/pdf_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<StudentModel> _userList = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUsers() async {
    try {
      QuerySnapshot res = await ApiService.getStudents();
      List<StudentModel> users =
          res.docs.map((doc) => StudentModel.fromFirestore(doc)).toList();
      print(users);
      setState(() {
        _userList = users;
      });
    } catch (e) {
      print(e);
    }
  }

  void downloadPdf(contex) async {
    List<Map<String, dynamic>> userListJson =
        _userList.map((student) => student.toJson()).toList();

    final data = [
      ['Student Name', 'Roll Number', 'Address', 'Department'],
      ..._userList.map((record) => [
            record.studentName,
            record.rollNumber,
            record.address,
            record.department,
          ]),
    ];
    try {
      Uint8List pdfByte =
          await PDFService.createPDFReport(data, "Student List");
      final result = PDFService.savePdfFile("students_reports", pdfByte);
      print("result-");
      print(result);
    } catch (e) {
      print(e);
    }
  }

  void handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: 'Confirm Logout',
          content: 'Are you sure you want to log out?',
          onConfirm: () async {
            await ApiService.signoutUser();

            Navigator.of(context).pushReplacementNamed('/login');
            print('Logging out...');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
              onPressed: () {
                handleLogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Student Records"),
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return Theme.of(context).primaryColor;
                      },
                    ),
                  ),
                  onPressed: () {
                    downloadPdf(context);
                  },
                  child: Text("Download Pdf"))
            ]),
            Expanded(
                child: ListView.builder(
                    itemCount: _userList.length,
                    itemBuilder: (context, index) {
                      final studentName = _userList[index].studentName;
                      final rollNo = _userList[index].rollNumber;
                      final address = _userList[index].address;
                      final department = _userList[index].department;
                      return Card(
                        // color: Colors.indigo.shade100,
                        color: Colors.white,

                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Student Name",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text("$studentName"),
                              const SizedBox(height: 10),
                              Text("Roll Number & Department",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              Text("$rollNo - $department"),
                              const SizedBox(height: 10),
                              Text("Roll Number & Department",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              Text("$address"),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
