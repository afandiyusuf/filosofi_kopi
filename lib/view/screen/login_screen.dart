import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String tag = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: "Login"),
        body: Container(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: ListView(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text("Phone Number", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                      ),
                      TextField(
                        decoration: CustomTextFieldDecoration.create(),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 40, bottom: 5),
                          child: Text("6 digit PIN", style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                      ),
                      TextField(
                        decoration: CustomTextFieldDecoration.create(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:60),
                        child: RaisedButton(
                          onPressed: (){
                            _gotoMainScreen(context);
                          },
                          color: Style.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Style.primaryTextColor),
                          ),
                        ),
                      )
                    ]
                )
            )
        )
    );
  }

  _gotoMainScreen(BuildContext context){
    Navigator.pushNamed(context, MainScreen.tag);
  }

}
