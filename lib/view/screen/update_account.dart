import 'package:filkop_mobile_apps/bloc/register/register_bloc.dart';
import 'package:filkop_mobile_apps/bloc/register/register_state.dart';
import 'package:filkop_mobile_apps/model/get_user_result.dart';
import 'package:filkop_mobile_apps/model/user_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Future<GetUserResult> getUserResult;
  bool _isLoading = false;
  @override
  void initState() {
    getUserResult = ApiService().getUser();
    super.initState();
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
              child: FutureBuilder<GetUserResult>(
                future: getUserResult,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if (snapshot.data.success) {
                      GetUserResult result = snapshot.data;
                      _emailTxt.text = result.data.data.email;
                      _phoneTxt.text = result.data.data.phone;
                      _fullName.text = result.data.data.firstName;

                      return ListView(
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
                              margin: EdgeInsets.only(top: 40, bottom: 5),
                              child: Text("Password (kosongkan jika tidak ingin diubah)",
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          Stack(
                            children: [
                              TextFormField(
                                obscureText: passwordVisibility,
                                controller: _passwordTxt,
                                decoration: CustomTextFieldDecoration.create(),
                                validator: (value) {
                                  print(value.length);
                                  if(value.isEmpty){
                                    return null;
                                  }
                                  if (value.length <= 5) {
                                    return "password must be 6 character or more";
                                  }
                                  return null;
                                },
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                    icon: Icon(
                                      (passwordVisibility) ? Icons.visibility : Icons.visibility_off, size: 20,),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisibility = !passwordVisibility;
                                      });
                                    }),
                              )
                            ],
                          ),


                          BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                if (state is Registering) {
                                  return Center(child: CircularProgressIndicator(),);
                                }

                                return (!_isLoading)?Container(
                                  margin: EdgeInsets.only(top: 60, bottom: 60),
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
                                ):Center(child: Padding(
                                  padding: const EdgeInsets.all(60.0),
                                  child: CircularProgressIndicator(),
                                ),);
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
                      );
                    }else{
                      return Center(child: Text("Terjadi kesalahan, perikas koneksi anda dan muat ulang halaman ini"),);
                    }
                  }

                  return Center(child: CircularProgressIndicator(),);
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  _register(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
    bool result = await ApiService().updateUser(
        fullName: _fullName.text,
        password: _passwordTxt.text,
        email: _emailTxt.text,
        phoneNumber: _phoneTxt.text,
      );
    if(result){
      Fluttertoast.showToast(msg: "Success");
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: "Terjadi kesalahan, mohon ulangi lagi nanti");
    }
    }else{
      print('error bosque');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
