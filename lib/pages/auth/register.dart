import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentms/components/CustomButton.dart';
import 'package:studentms/components/ThemeInput.dart';
import 'package:studentms/model/user.dart';
import 'package:studentms/services/api_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // create user form value
  handleRegister(context) async {
    if (!_formKey.currentState!.validate()) {
      print('Form is invalid. Please correct errors.');
      return;
    }
    Map<String, dynamic> userData = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "mobileno": mobileNoController.text.trim(),
      "email": emailController.text.trim(),
    };

    QuerySnapshot user = await ApiService.getUserById(userData['mobileno']);
    print(user.size);
    print(userData);
    if (user.size == 0) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String userId = userCredential.user!.uid;
        await ApiService.addUser(userData, userId).then((res) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green.shade400,
            content: Text("User Registered Successfully"),
          ));
        });
        print("succcessss");
        print(userCredential);

        Navigator.of(context).pushReplacementNamed("/login");
      } on FirebaseAuthException catch (e) {
        print("object");
        print(e.code);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Text("${e.code}"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Text("User All ready Exist!!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Student Management System",
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                ),
                const SizedBox(height: 25),
                const SizedBox(height: 10),
                ThemeInput(
                  inputController: firstNameController,
                  inputLabel: "First Name",
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid Name';
                    }
                  },
                ),
                const SizedBox(height: 10),
                ThemeInput(
                    inputController: lastNameController,
                    inputLabel: "Last Name",
                    prefixIcon: Icons.person),
                const SizedBox(height: 10),
                ThemeInput(
                    minLength: 10,
                    maxLength: 10,
                    inputController: mobileNoController,
                    inputLabel: "Mobile Number",
                    type: "mobile",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Mobile';
                      }
                      if (value.length > 0 && value.length <= 10) {
                        return 'Please enter 10 digit Mobile';
                      }
                    },
                    prefixIcon: Icons.phone_android),
                const SizedBox(height: 10),
                ThemeInput(
                    inputController: emailController,
                    inputLabel: "Email",
                    type: "email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Email';
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter valid Email';
                      }
                    },
                    prefixIcon: Icons.email),
                const SizedBox(height: 10),
                ThemeInput(
                  inputController: passwordController,
                  inputLabel: "Password",
                  minLength: 8,
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    if (value >= 8) {
                      return 'Password must be 8 Characters';
                    }
                  },
                ),
                const SizedBox(height: 10),
                ThemeInput(
                  inputController: confirmPasswordController,
                  inputLabel: "Confirm Password",
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Confirm Password';
                    }
                    if (value != confirmPasswordController.text) {
                      return 'Password and Confirm Password not matched';
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    handleRegister(context);
                  },
                  text: 'Submit',
                  disabled: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have  an Account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/login");
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
