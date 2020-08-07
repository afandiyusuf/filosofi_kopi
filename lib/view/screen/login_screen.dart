import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static final String tag = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _usernameTxt = TextEditingController(text:"");
  TextEditingController _passwordTxt = TextEditingController(text:"");

  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: CustomAppBar(titleText: "Login"),
        body: Form(
          key: _formKey,
          child: Container(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: ListView(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text("Email", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)
                        ),
                        TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameTxt,
                          decoration: CustomTextFieldDecoration.create(),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 40, bottom: 5),
                            child: Text("Password", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)
                        ),
                        TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please your password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordTxt,
                          obscureText: true,
                          decoration: CustomTextFieldDecoration.create(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:60),
                          child: RaisedButton(
                            onPressed: (){
                              _attempLogin(context);
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
          ),
        )
    );

  }

  _attempLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    _scaffoldKey?.currentState?.showSnackBar(SnackBar(
      content: Text("Logging in..."),
    ));

    Future<BaseResponse> response = ApiService().login(_usernameTxt.text, _passwordTxt.text);
      response.then((value) =>
    {
      if(value.success == true){
          _saveToken(context,value.data.token)
      }else{
        _scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(value.msg),
        ))
      }
    });



  }
  _saveToken(BuildContext context, String token) async
  {
    SharedPreferences pref = await _prefs;
    pref.setString("token", token);
    Navigator.pushNamed(context, MainScreen.tag);
  }

}
