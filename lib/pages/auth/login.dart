import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentms/components/CustomButton.dart';
import 'package:studentms/components/ThemeInput.dart';
import 'package:studentms/services/api_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // login function
  handleLogin(context) async {
    try {
      final res = await ApiService.loginUser(
          emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Text("Login Successfully"),
      ));
      Navigator.of(context).pushReplacementNamed("/");
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Text("User Failed"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
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
              ThemeInput(
                inputController: emailController,
                inputLabel: "Email",
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                },
              ),
              const SizedBox(height: 20),
              ThemeInput(
                inputController: passwordController,
                inputLabel: "Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  }
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  handleLogin(context);
                },
                text: 'Login Now',
                disabled: false,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have a login ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/register");
                      },
                      child: Text("Signup"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
