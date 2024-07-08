import 'package:flutter/material.dart';
import 'package:studentms/pages/auth/login.dart';
import 'package:studentms/pages/auth/register.dart';
import 'package:studentms/pages/home/dashboard.dart';

class RoutePage extends StatelessWidget {
  final String initialRoute;

  const RoutePage({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(primaryColor: Colors.blue.shade900),
      title: 'Student MS',
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}
