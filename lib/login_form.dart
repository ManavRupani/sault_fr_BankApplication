import 'package:flutter/material.dart';
import 'api_service.dart';
import 'dart:convert';
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final filter = {
      "@type": "DataLakeItem",
      "About": {
        "@type": "UserAccount",
        "Username": username,
        "Password": password,
      }
    };

    final response = await _apiService.searchData(filter);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Result']['NumberOfItems'] > 0) {
        // Handle successful login
        print('Login successful');
      } else {
        // Handle invalid credentials
        print('Invalid credentials');
      }
    } else {
      // Handle login failure
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _loginUser();
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
