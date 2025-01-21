// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/authentication/views/login.dart';
import 'package:app/features/authentication/views/signup.dart';
import 'package:app/features/authentication/views/support.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Authentication"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Builder(
            builder: (BuildContext context) {
              return TabBarView(
                children: [
                  AuthenticationLogin(),
                  AuthenticationSignup(),
                  AuthenticationSupport(),
                ],
              );
            },
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login)),
              Tab(icon: Icon(Icons.person_add)),
              Tab(icon: Icon(Icons.manage_accounts)),
            ],
          ),
        ),
      ),
    );
  }
}
