import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/screen/login_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static final String tag = '/verify-phone';

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Verify Phone Number"),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus mi vitae nunc.",
                  textAlign: TextAlign.center,
                )),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 0.7,
              child: PinCodeTextField(
                length: 4,
                obsecureText: false,
                backgroundColor: Colors.white.withOpacity(0),
                animationType: AnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
                pinTheme: PinTheme(
                  activeColor: Colors.black,
                  selectedColor: Colors.black,
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(20),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: hasError ? Colors.black : Colors.white,
                  inactiveFillColor: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.8,
                child: RaisedButton(
                  onPressed: () {
                    _goToLoginScreen(context);
                  },
                  color: Style.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(color: Style.primaryTextColor),
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                        color: Style.secondaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
  _goToLoginScreen(BuildContext context)
  {
    Navigator.pushNamed(context, LoginScreen.tag);
  }
}
