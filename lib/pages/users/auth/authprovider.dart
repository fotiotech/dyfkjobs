import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  Future<void> handleSignIn(
      final GlobalKey<FormState> _formKey,
      String emailController,
      String passwordController,
      BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController,
          password: passwordController,
        );

        print('Signing in Successful!');
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/');
      } catch (error) {
        // Handle potential errors during communication
        print('Error during Signing in: $error');
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/');
  }
}
