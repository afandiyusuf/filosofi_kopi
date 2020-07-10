import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items:[
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), title: Text("Menu")),
        BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("Merchandize")),
        BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("Profile"))
      ],
    );
  }
}