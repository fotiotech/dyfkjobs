import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  const MySquare({super.key, required this.child});

  final String child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Text(
            child,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
