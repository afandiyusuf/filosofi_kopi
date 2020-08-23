import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/verify_phone_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  static final String tag = '/create-account';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameTxt = TextEditingController(text:"");
  TextEditingController _emailTxt = TextEditingController(text:"");
  TextEditingController _phoneTxt = TextEditingController(text:"");
  TextEditingController _fullName = TextEditingController(text:"");
  TextEditingController _referalCode = TextEditingController(text:"");

  TextEditingController _passwordTxt = TextEditingController(text:"");
  TextEditingController _cPasswordTxt = TextEditingController(text:"");

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Create account"),
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
                    child: Text("Username",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _usernameTxt,
                  validator: (value){
                    if(value == "")
                    {
                      return "Username can not be null";
                    }else{
                      return "";
                    }
                  },
                  decoration: CustomTextFieldDecoration.create(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text("Email",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _emailTxt,
                  decoration: CustomTextFieldDecoration.create(),
                  validator: (value){
                    if(value == "")
                    {
                      return "Email can not be null";
                    }else{
                      return "";
                    }
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text("Phone Number",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _phoneTxt,
                  decoration: CustomTextFieldDecoration.create(),
                  validator: (value){
                    if(value == "")
                    {
                      return "Phone Number can not be null";
                    }else{
                      return "";
                    }
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Text("Full Name",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _fullName,
                  decoration: CustomTextFieldDecoration.create(),
                  validator: (value){
                    if(value == "")
                    {
                      return "Fullname can not be null";
                    }else{
                      return "";
                    }
                  },
                ),
                Container(
                  margin:EdgeInsets.only(top: 40),
                  child: Text("Birth Date",style: TextStyle(
                      fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin:EdgeInsets.only(left: 30),
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.white,
                          onPressed: () => _selectDate(context),
                          child: Text('Select date',style: TextStyle(
                              fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Text("Refferal Code (Optional)",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _referalCode,
                  decoration: CustomTextFieldDecoration.create(),
                ),

                Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Text("Password",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _passwordTxt,
                  decoration: CustomTextFieldDecoration.create(),
                  validator: (value){
                    if(value.length <=5){
                      return "password must be 6 character or more";
                    }

                    return "";
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Text("Confirm Password",style: TextStyle(
                        fontWeight: FontWeight.bold))
                ),
                TextFormField(
                  controller: _cPasswordTxt,
                  decoration: CustomTextFieldDecoration.create(),
                  validator: (value){

                   if(value != _passwordTxt.text){
                     return "password confirmation must be same with your password";
                   }

                    return "";
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top:60),
                  child: RaisedButton(
                    onPressed: (){
                      _register(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  _goToNextScreen(BuildContext context){
    Navigator.pushNamed(context, VerifyPhoneScreen.tag);
  }
  _register(BuildContext context){
    if(_formKey.currentState.validate()){

    }
  }
}
