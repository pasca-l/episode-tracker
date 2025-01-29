// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/authentication/repositories/authentication.dart';

class AuthenticationLogin extends StatefulWidget {
  const AuthenticationLogin({super.key});

  @override
  State<AuthenticationLogin> createState() => _AuthenticationLoginState();
}

class _AuthenticationLoginState extends State<AuthenticationLogin> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;
  final RegExp _emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  bool _hidePassword = true;

  // checks if the form has some value for each textinput,
  // but does not check for validity
  bool _isFormFilled = false;
  void checkFormFill() {
    setState(() {
      _isFormFilled =
          _controllers["email"]!.text.isNotEmpty &&
          _controllers["password"]!.text.isNotEmpty;
    });
  }

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
              spacing: 20,
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
                        onChanged: (_) {
                          checkFormFill();
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter some email address";
                          }
                          if (!_emailPattern.hasMatch(val)) {
                            return "Please enter a valid form of an email address";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
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
                        onChanged: (_) {
                          checkFormFill();
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter some password";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      _isFormFilled
                          ? () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await AuthenticationRepository.logIn(
                                  _controllers["email"]!.text.trim(),
                                  _controllers["password"]!.text.trim(),
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).clearSnackBars();
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      duration: Duration(days: 1),
                                      action: SnackBarAction(
                                        label: 'Dismiss',
                                        textColor: Colors.white,
                                        onPressed: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).hideCurrentSnackBar();
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please check the inputs"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                          : null,
                  child: Text("login"),
                ),
                Divider(),
                ElevatedButton(onPressed: null, child: Text("Google signin")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
