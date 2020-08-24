import 'package:filkop_mobile_apps/bloc/city/city_bloc.dart';
import 'package:filkop_mobile_apps/bloc/city/city_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_state.dart';
import 'package:filkop_mobile_apps/bloc/province/province_bloc.dart';
import 'package:filkop_mobile_apps/bloc/province/province_event.dart';
import 'package:filkop_mobile_apps/bloc/province/province_state.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/model/province_model.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:filkop_mobile_apps/service/rajaongkir_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/screen/verify_phone_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String provinceValue;
  String cityValue;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProvinceBloc(
              rajaOngkirRepository:
                  RajaOngkirRepository(rajaOngkirService: RajaOngkirService())),
        ),
        BlocProvider(
          create: (_) => CityBloc(
            rajaOngkirRepository:
                RajaOngkirRepository(rajaOngkirService: RajaOngkirService()),
          ),
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
                      if (value == "") {
                        return "Username can not be null";
                      } else {
                        return "";
                      }
                    },
                    decoration: CustomTextFieldDecoration.create(),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text("Email",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _emailTxt,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      if (value == "") {
                        return "Email can not be null";
                      } else {
                        return "";
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
                    validator: (value) {
                      if (value == "") {
                        return "Phone Number can not be null";
                      } else {
                        return "";
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
                      if (value == "") {
                        return "Fullname can not be null";
                      } else {
                        return "";
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
                            .add(FetchCity(province_id: datas[0].id));
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 12, right: 12),
                          child: DropdownButton<String>(
                            underline: Container(),
                            onChanged: (String newValue) {
                              Province selectedProvince = datas.firstWhere(
                                  (element) => element.name == newValue);
                              setState(() {
                                provinceValue = newValue;
                                cityValue = null;
                                context.bloc<CityBloc>().add(FetchCity(
                                    province_id: selectedProvince.id));
                              });
                            },
                            value: provinceValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            items: dropDownItem,
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

                                cityValue = citiesData[0].name;

                                return DropdownButton<String>(
                                  onChanged: (String newValue) {
                                    setState(() {
                                      cityValue = newValue;
                                    });
                                  },
                                  value: cityValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  items: dropDownItem,
                                  underline: Container(),
                                );
                              }
                              return Container();
                            },
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Password",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _passwordTxt,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      if (value.length <= 5) {
                        return "password must be 6 character or more";
                      }

                      return "";
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text("Confirm Password",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                    controller: _cPasswordTxt,
                    decoration: CustomTextFieldDecoration.create(),
                    validator: (value) {
                      if (value != _passwordTxt.text) {
                        return "password confirmation must be same with your password";
                      }

                      return "";
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _goToNextScreen(BuildContext context) {
    Navigator.pushNamed(context, VerifyPhoneScreen.tag);
  }

  _register(BuildContext context) {
    if (_formKey.currentState.validate()) {}
  }
}
