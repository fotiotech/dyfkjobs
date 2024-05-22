import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/pages/users/account.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Fotio',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans'),
            ),
            accountEmail: Text(
              user?.email ?? 'Guest',
              style: TextStyle(fontSize: 14.0, fontFamily: 'Sans'),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('images/mm.jpg',
                    width: 90, height: 90, fit: BoxFit.cover),
              ),
            ),
            onDetailsPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Account()));
            },
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('images/nature.jpg'))),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Friends'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Request'),
            onTap: () {},
            trailing: ClipOval(
                child: Container(
              color: Colors.red,
              width: 20,
              height: 20,
              child: const Center(
                  child: Text(
                '8',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              )),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
