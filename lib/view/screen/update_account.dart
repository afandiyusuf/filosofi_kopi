import 'package:filkop_mobile_apps/bloc/register/register_bloc.dart';
import 'package:filkop_mobile_apps/bloc/register/register_state.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

class UpdateAccountScreen extends StatefulWidget {
  static final String tag = '/update-account';

  @override
  _UpdateAccountScreenState createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTxt = TextEditingController(text: "");
  TextEditingController _phoneTxt = TextEditingController(text: "");
  TextEditingController _fullName = TextEditingController(text: "");
  TextEditingController _passwordTxt = TextEditingController(text: "");
  bool passwordVisibility = true;
  bool cPassowrdVisibility = true;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(apiService: ApiService()),
        )
      ],
      child: Scaffold(
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
                      child: Text("Email",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTxt,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email can not be null";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text("Phone Number",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _phoneTxt,
                    decoration: CustomTextFieldDecoration.create(),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Phone Number can not be null";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Full Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _fullName,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Fullname can not be null";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text("Birth Date",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                          margin: EdgeInsets.only(left: 30),
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.white,
                            onPressed: () => _selectDate(context),
                            child: Text('Select date',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),




                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Password",
                          style: TextStyle(fontWeight: FontWeight.bold))),
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



                  BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {

                        if(state is Registering){
                          return Center(child: CircularProgressIndicator(),);
                        }

                        return Container(
                          margin: EdgeInsets.only(top: 60,bottom: 60),
                          child: RaisedButton(
                            onPressed: () {
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
                        );
                      }
                  ),
                  BlocListener<RegisterBloc, RegisterState>(
                    listener: (registerContext, registerState) {
                      if (registerState is Registering) {
                        Scaffold.of(registerContext).showSnackBar(SnackBar(
                          content: Text('Registering'),
                          duration: 2.seconds,
                        ));
                      } else if (registerState is RegisterSuccess) {
                        Scaffold.of(registerContext).showSnackBar(SnackBar(
                          content: Text('Success'),
                          duration: 2.seconds,
                        ));
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.pushNamed(registerContext, MainScreen.tag);
                        });
                      } else if (registerState is RegisterError) {
                        Scaffold.of(registerContext).showSnackBar(SnackBar(
                          content: Text(registerState.message),
                          duration: 2.seconds,
                        ));
                      }
                    },
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _register(BuildContext context) {
    if (_formKey.currentState.validate()) {
      //update here
//      String parsedGender = (gender == 'laki - laki') ? 'M' : 'F';
//      context.bloc<RegisterBloc>().add(SendDataRegister(
//        birthDate: selectedDate.toLocal().toString(),
//        username: _usernameTxt.text,
//        password: _passwordTxt.text,
//        gender: parsedGender,
//        province: provinceValue,
//        city: realCityValue,
//        phoneNumber: _phoneTxt.text,
//        pin: _pinTxt.text,
//        email: _emailTxt.text,
//        fullName: _fullName.text,
//      ));
    }else{
      print('error bosque');
    }
  }
}
