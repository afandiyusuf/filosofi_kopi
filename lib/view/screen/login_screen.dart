import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  static final String tag = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _usernameTxt = TextEditingController(text:"");
  TextEditingController _passwordTxt = TextEditingController(text:"");
  bool passwordVisibility = false;
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
                        Stack(
                          children: [
                            TextFormField(
                              obscureText: passwordVisibility,
                              controller: _passwordTxt,
                              decoration: CustomTextFieldDecoration.create(),
                              validator: (value) {
                                print(value.length);
                                if (value.length <= 5) {
                                  return "password must be 6 character or more";
                                }
                                return null;
                              },
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(icon: Icon( (passwordVisibility)? Icons.visibility : Icons.visibility_off, size: 20,), onPressed: (){
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              }),
                            )
                          ],
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
      duration: Duration(seconds: 3),
      content: Text("Logging in..."),
    ));

    BaseResponse response = await ApiService().login(_usernameTxt.text, _passwordTxt.text);
      if(response.success == true){
        print("HEREEEE");
         Navigator.pushNamed(context, MainScreen.tag);
      }else{
        _scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(response.msg),
        ));
      }
  }
}
