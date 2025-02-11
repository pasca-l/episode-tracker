// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:app/features/authentication/repositories/authentication.dart';

class AuthenticationDrawer extends StatelessWidget {
  const AuthenticationDrawer({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text(user!.uid)),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              AuthenticationRepository.logOut();
            },
          ),
        ],
      ),
    );
  }
}
