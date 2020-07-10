import 'package:filkop_mobile_apps/view/component/bottom_navbar.dart';
import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const tag = '/main';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
