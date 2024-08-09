import 'package:flutter/material.dart';
import 'registration_form.dart';
import 'login_form.dart';
import 'account_management.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Banking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginForm(),
      routes: {
        '/register': (context) => RegistrationForm(),
        '/login': (context) => LoginForm(),
      },
    );
  }
}
