import 'package:flutter/material.dart';
import 'package:flutter_app_1/pages/homepage.dart';
import 'package:flutter_app_1/pages/users/signIn.dart';
import 'package:provider/provider.dart';
import 'authprovider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isAuthenticated ? HomePage() : SignInPage();
  }
}
