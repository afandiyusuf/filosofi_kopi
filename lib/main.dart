import 'package:filkop_mobile_apps/view/screen/create_account_screen.dart';
import 'package:filkop_mobile_apps/view/screen/login_screen.dart';
import 'package:filkop_mobile_apps/view/screen/on_boarding_screen.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:filkop_mobile_apps/view/screen/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:filkop_mobile_apps/view/screen/signin_screen.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';


void main() {
  const rootRoute = '/';
  var rootScreen = OnBoardingScreen();

  runApp(MaterialApp(
    initialRoute: rootRoute,
    routes: {
      rootRoute : (context) => rootScreen,
      SignInScreen.tag : (context) => SignInScreen(),
      MainScreen.tag : (context) => MainScreen(),
      CreateAccountScreen.tag : (context) => CreateAccountScreen(),
      VerifyPhoneScreen.tag : (context) => VerifyPhoneScreen(),
      LoginScreen.tag : (context) => LoginScreen(),
      PickOurStoresScreen.tag : (context) => PickOurStoresScreen()
    },
  ));
}

