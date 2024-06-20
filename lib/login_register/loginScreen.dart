import 'package:api_flutter_1/login_register/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScrenn extends StatefulWidget {
  const LoginScrenn({super.key});

  @override
  State<LoginScrenn> createState() => _LoginScrennState();
}

class _LoginScrennState extends State<LoginScrenn> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Consumer<LoginController>(
            builder: (context, Loginvalues, child) {
              return Form(
                key: Loginvalues.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: Loginvalues.LoginEmailController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: Loginvalues.LoginPasswordController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (Loginvalues.loginFormKey.currentState!
                              .validate()) {
                            Loginvalues.usersLogin(
                              Loginvalues.LoginEmailController,
                              Loginvalues.LoginPasswordController,
                            );
                          }
                        },
                        child: Text('Login'))
                  ],
                ),
              );
            },
          )),
    );
  }
}
