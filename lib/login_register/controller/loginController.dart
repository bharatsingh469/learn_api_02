// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController with ChangeNotifier {
  TextEditingController LoginEmailController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  usersLogin(TextEditingController loginEmailController,
      TextEditingController loginPasswordController) async {
    try {
      var headers = {"Content-Type": "application/json"};
      var body = {
        'email': loginEmailController.text.trim(),
        'password': loginPasswordController.text.trim(),
      };

      http.Response response = await http.post(
        Uri.parse("https://reqres.in/api/login"),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body.toString());
        print('Token print hua h');
        print(json['token']);

        if (json['token'] != '') {
//Navigator.pushNamed(context as BuildContext, 'home');
         
          print('Login ho chuka h ji');
        } else {
          print("Invalid Details");
        }
      }
    } catch (e) {
      print('Error is not hit h api $e');
    }
  }
}
