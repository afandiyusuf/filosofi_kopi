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
      body: Container(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text("Phone Number",style: TextStyle(
                      fontWeight: FontWeight.bold))
              ),
              TextField(
                decoration: CustomTextFieldDecoration.create(),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40, bottom: 5),
                  child: Text("6-digits PIN",style: TextStyle(
                      fontWeight: FontWeight.bold))
              ),
              TextField(
                decoration: CustomTextFieldDecoration.create(),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40, bottom: 5),
                  child: Text("Full Name",style: TextStyle(
                      fontWeight: FontWeight.bold))
              ),
              TextField(
                decoration: CustomTextFieldDecoration.create(),
              ),
              Text("Birth Date",style: TextStyle(
                  fontWeight: FontWeight.bold)),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 5),
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
              TextField(
                decoration: CustomTextFieldDecoration.create(),
              ),
              Container(
                margin: EdgeInsets.only(top:60),
                child: RaisedButton(
                  onPressed: (){
                    _goToNextScreen(context);
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
    );
  }
  _goToNextScreen(BuildContext context){
    Navigator.pushNamed(context, VerifyPhoneScreen.tag);
  }
}
