import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeforeLoginScreen extends StatefulWidget {
  static const String tag = "/before-login";
  @override
  _BeforeLoginScreenState createState() => _BeforeLoginScreenState();
}

class _BeforeLoginScreenState extends State<BeforeLoginScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void checkLogin(BuildContext context) async{
    SharedPreferences pref = await _prefs;
    if(pref.getString("token") != null){
      String token = pref.getString("token");
      int response = await ApiService().checkLogin({"token":token});
      print(response);
      if(response == 1){
        Navigator.popAndPushNamed(context, MainScreen.tag);
      }else if(response == 0){
        Navigator.popAndPushNamed(context, OnBoardingScreen.tag);
      }else{
        Navigator.popAndPushNamed(context, OnBoardingScreen.tag);
      }
    }else{
      Navigator.popAndPushNamed(context, OnBoardingScreen.tag);
    }
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero,() {
      checkLogin(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
                child: Image.asset("images/logo-font.png")),
            SizedBox(height: 5,),
            Text("Mohon tunggu..."),
            SizedBox(height: 30,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
