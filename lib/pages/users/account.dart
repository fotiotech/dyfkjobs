import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/pages/admin/AdminPanel.dart';
import 'package:flutter_app_1/pages/users/IntroPage.dart';
import 'package:flutter_app_1/pages/users/signup.dart';
import 'package:flutter_app_1/pages/users/signin.dart';
import 'package:flutter_app_1/pages/users/auth/authprovider.dart'
    as MyAppAuthProvider;

import 'createposte.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAppAuthProvider.AuthProvider authService =
        MyAppAuthProvider.AuthProvider();
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Fotio',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans'),
            ),
            accountEmail: Text(
              user?.email ?? 'Guest',
              style: const TextStyle(fontSize: 14.0, fontFamily: 'Sans'),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('images/mm.jpg',
                    width: 90, height: 90, fit: BoxFit.cover),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('images/nature.jpg'))),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Admin Panel'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminPanel()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create Post'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePost()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Complete your about'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IntroPage()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await authService.logout(
                    context,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
