import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:filkop_mobile_apps/view/screen/pages/menu.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static final String tag = '/main';

  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _selectedIndex = 0;
  static final String tag = '/main';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomePage(),
      Menu(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("HOME", style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text("MENU", style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text("MERCHANDHISE", style: _bottomNavBarStyle()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text("PROFILE", style: _bottomNavBarStyle()),
          ),
        ],
      ),
    );
  }

  TextStyle _bottomNavBarStyle() {
    return TextStyle(fontSize: 9);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
}
