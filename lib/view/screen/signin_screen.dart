import 'package:filkop_mobile_apps/view/screen/create_account_screen.dart';
import 'package:filkop_mobile_apps/view/screen/login_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static final String tag = '/sign-in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                child: Image.asset('images/logo-font.png'),
                width: 220,
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.4),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: RaisedButton(
                  key: Key('create-account-button'),
                  onPressed: () {
                    _goToCreateAccount(context);
                  },
                  color: Style.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Style.primaryTextColor),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: RaisedButton(
                  key: Key('login-button'),
                  onPressed: () {
                    _gotoLoginScreen(context);
                  },
                  color: Style.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Style.secondaryTextColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _goToCreateAccount(BuildContext context){
    Navigator.pushNamed(context, CreateAccountScreen.tag);
  }
  _gotoLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.tag);
  }
}
