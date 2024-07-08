import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studentms/model/user.dart';
import 'package:studentms/route.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Listen  state changes
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    String initialRoute = user == null ? 'login' : '/';

    Widget routeApp = RoutePage(
      initialRoute: initialRoute,
    );
    // Create the app initialRoute
    runApp(routeApp);
  });
}
