import 'package:filkop_mobile_apps/bloc/city/city_bloc.dart';
import 'package:filkop_mobile_apps/bloc/city/city_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_state.dart';
import 'package:filkop_mobile_apps/bloc/province/province_bloc.dart';
import 'package:filkop_mobile_apps/bloc/province/province_event.dart';
import 'package:filkop_mobile_apps/bloc/province/province_state.dart';
import 'package:filkop_mobile_apps/bloc/register/register_bloc.dart';
import 'package:filkop_mobile_apps/bloc/register/register_event.dart';
import 'package:filkop_mobile_apps/bloc/register/register_state.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/model/province_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

class CreateAccountScreen extends StatefulWidget {
  static final String tag = '/create-account';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameTxt = TextEditingController(text: "");
  TextEditingController _emailTxt = TextEditingController(text: "");
  TextEditingController _phoneTxt = TextEditingController(text: "");
  TextEditingController _fullName = TextEditingController(text: "");
  TextEditingController _referalCode = TextEditingController(text: "");

  TextEditingController _passwordTxt = TextEditingController(text: "");
  TextEditingController _cPasswordTxt = TextEditingController(text: "");
  TextEditingController _pinTxt = TextEditingController(text: "");
  String provinceValue;
  String cityValue;
  String realCityValue;
  bool passwordVisibility = true;
  bool cPassowrdVisibility = true;
  String gender = "Laki - laki";
  List<String> genders = ['Laki - laki', 'Perempuan'];

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
                      child: Text("Username",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _usernameTxt,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Username can not be null";
                      } else {
                        return null;
                      }
                    },
                    decoration: CustomTextFieldDecoration.create(),
                  ),
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
                      child: Text("Refferal Code (Optional)",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _referalCode,
                    decoration: CustomTextFieldDecoration.create(),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Jenis Kelamin",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 12, right: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          underline: Container(),
                          onChanged: (String newValue) {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus.unfocus();
                            }

                            setState(() {
                              gender = newValue;
                            });
                          },
                          value: gender,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          items: genders
                              .map<DropdownMenuItem<String>>((String data) {
                            return DropdownMenuItem<String>(
                              value: data,
                              child: Text(data),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Provinsi",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  BlocBuilder<ProvinceBloc, ProvinceState>(
                      builder: (context, state) {
                    if (state is ProvinceInit) {
                      context.bloc<ProvinceBloc>().add(FetchProvince());
                    }
                    if (state is ProvinceReady) {
                      List<Province> datas = state.province;
                      List<DropdownMenuItem<String>> dropDownItem = datas
                          .map<DropdownMenuItem<String>>((Province province) {
                        return DropdownMenuItem<String>(
                          value: province.name,
                          child: Text(province.name),
                        );
                      }).toList();
                      if (provinceValue == null) {
                        provinceValue = datas[0].name;
                        context
                            .bloc<CityBloc>()
                            .add(FetchCity(provinceId: datas[0].id));
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 12, right: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              underline: Container(),
                              onChanged: (String newValue) {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                  FocusManager.instance.primaryFocus.unfocus();
                                }

                                Province selectedProvince = datas.firstWhere(
                                    (element) => element.name == newValue);
                                setState(() {
                                  provinceValue = newValue;
                                  cityValue = null;
                                  context.bloc<CityBloc>().add(FetchCity(
                                      provinceId: selectedProvince.id));
                                });
                              },
                              value: provinceValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              items: dropDownItem,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Kota",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 12, right: 12),
                          child: BlocBuilder<CityBloc, CityState>(
                            builder: (context, state) {
                              if (state is CityEmpty) {
                                return Container(
                                  child: Center(
                                    child:
                                        Text("Pilih provinsi terlebih dahulu"),
                                  ),
                                );
                              }
                              if (state is CityLoading) {
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                              if (state is CityReady) {
                                List<City> citiesData = state.cities;
                                List<DropdownMenuItem<String>> dropDownItem =
                                    citiesData.map<DropdownMenuItem<String>>(
                                        (City city) {
                                  return DropdownMenuItem<String>(
                                    value: city.name,
                                    child: Text(city.name),
                                  );
                                }).toList();

                                cityValue = state.selectedCities;
                                realCityValue = state.realCityName;

                                return DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    onChanged: (String newValue) {
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                        FocusManager.instance.primaryFocus.unfocus();
                                      }

                                      setState(() {
                                        cityValue = newValue;
                                        realCityValue = citiesData.firstWhere((city) => city.name == newValue).realCityName;
                                        context.bloc<CityBloc>().add(SelectCity(newValue,realCityValue));
                                      });
                                    },
                                    value: cityValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    items: dropDownItem,
                                    underline: Container(),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ))),
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
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Confirm Password",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Stack(
                    children: [
                      TextFormField(
                        obscureText: cPassowrdVisibility,
                        controller: _cPasswordTxt,
                        decoration: CustomTextFieldDecoration.create(),
                        validator: (value) {
                          if (value != _passwordTxt.text) {
                            return "password confirmation must be same with your password";
                          }

                          return null;
                        },
                      ),

                      Positioned(
                        right: 0,
                        child: IconButton(icon: Icon( (cPassowrdVisibility)? Icons.visibility : Icons.visibility_off, size: 20), onPressed: (){
                          setState(() {
                            cPassowrdVisibility = !cPassowrdVisibility;
                          });
                        }),
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("PIN (6 digit)",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _pinTxt,
                    keyboardType: TextInputType.number,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      return null;
                    },
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
      String parsedGender = (gender == 'laki - laki') ? 'M' : 'F';
      context.bloc<RegisterBloc>().add(SendDataRegister(
            birthDate: selectedDate.toLocal().toString(),
            username: _usernameTxt.text,
            password: _passwordTxt.text,
            gender: parsedGender,
            province: provinceValue,
            city: realCityValue,
            phoneNumber: _phoneTxt.text,
            pin: _pinTxt.text,
            email: _emailTxt.text,
            fullName: _fullName.text,
          ));
    }else{
      print('error bosque');
    }
  }
}
