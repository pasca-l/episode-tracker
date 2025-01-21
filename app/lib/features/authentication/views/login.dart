// Flutter imports:
import 'package:flutter/material.dart';

class AuthenticationLogin extends StatefulWidget {
  const AuthenticationLogin({super.key});

  @override
  State<AuthenticationLogin> createState() => _AuthenticationLoginState();
}

class _AuthenticationLoginState extends State<AuthenticationLogin> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;
  String _email = "";
  String _password = "";
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();

    // initialize text editing controllers
    _controllers = {
      "email": TextEditingController(),
      "password": TextEditingController(),
    };
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllers["email"],
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: "email",
                        ),
                        onChanged: (val) {
                          _email = val;
                        },
                      ),
                      TextFormField(
                        controller: _controllers["password"],
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _password = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text("login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
