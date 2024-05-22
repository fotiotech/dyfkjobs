import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  int currentindex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentindex,
      onTap: (int newIndex) {
        setState(() {
          currentindex = newIndex;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home,
            color: Colors.black,
            
          ),
          // activeIcon: Actions(actions: actions, child: child)
          
        ),
        BottomNavigationBarItem(
          label: 'Menu',
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),   
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void setState(Null Function() param0) {}
}
