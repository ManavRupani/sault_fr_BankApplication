import 'package:flutter/material.dart';
import 'api_service.dart';

class AccountManagement extends StatefulWidget {
  final String userId;

  AccountManagement({required this.userId});

  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  final _accountNameController = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _openNewAccount() async {
    final accountName = _accountNameController.text;

    final body = {
      "@context": [],
      "@type": "CreateAction",
      "Result": {
        "@type": "DataLakeItem",
        "About": {
          "@type": "BankAccount",
          "AccountName": accountName,
          "Owner": {
            "@type": "UserAccount",
            "Identifier": widget.userId,
          }
        }
      }
    };

    final response = await _apiService.postData(body);

    if (response.statusCode == 200) {
      print('Account created successfully');
    } else {
      print('Account creation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Accounts')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _accountNameController,
              decoration: InputDecoration(labelText: 'Account Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openNewAccount,
              child: Text('Open New Account'),
            ),
          ],
        ),
      ),
    );
  }
}
