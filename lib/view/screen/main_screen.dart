import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static final String tag = '/main';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),title: Text("HOME",style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),title: Text("MENU",style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),title: Text("MERCHANDHISE",style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),title: Text("PROFILE",style: _bottomNavBarStyle()),
          ),

        ],
      ),
    );
  }
  TextStyle _bottomNavBarStyle(){
    return TextStyle(
        fontSize: 9
    );
  }
}
