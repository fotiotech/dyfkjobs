import 'package:flutter/material.dart';

import 'component/AdminNavBar.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminNavBar(),
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: const Center(
        child: Text('Admin Panel!'),
      ),
    );
  }
}
