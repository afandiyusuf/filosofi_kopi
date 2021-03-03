import 'dart:convert';

import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_bloc.dart';
import 'package:filkop_mobile_apps/bloc/city/city_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_state.dart';
import 'package:filkop_mobile_apps/bloc/province/province_bloc.dart';
import 'package:filkop_mobile_apps/bloc/province/province_event.dart';
import 'package:filkop_mobile_apps/bloc/province/province_state.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_bloc.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_event.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/model/province_model.dart';
import 'package:filkop_mobile_apps/model/subdistrict.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/screen/address_screen.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressForm extends StatefulWidget {
  final UserAddress address;
  final bool isUpdate;

  const AddressForm({Key key, this.address, this.isUpdate = false});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  CameraPosition _cameraPosition;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  final _formKey = GlobalKey<FormState>();
  Future<String> selectMapState;
  CameraPosition lastCameraPosition;
  String selectedProvince;
  String selectedCity;
  String provinceValue;
  String cityValue;
  String subdistrictId;
  String subdistrictName;
  String realCityValue;
  int selectedCityId;
  Subdistrict subdistrictSelected;

  TextEditingController _detailedAddress = TextEditingController();
  TextEditingController _addressName = TextEditingController();


  void initState() {
    _detailedAddress.text = widget.address.address;
    _addressName.text = widget.address.name;
    if (widget.address.province != null) {
      provinceValue = widget.address.province;
    }
    if (widget.address.city != null) {
      cityValue = widget.address.city;
      realCityValue = widget.address.id;
    }

    if (widget.address.subdistrict != null) {
      subdistrictId = widget.address.subdistrict;
      subdistrictName = widget.address.subdistrict;
    }

    _cameraPosition = CameraPosition(
      target: _center,
      zoom: 11.0,
    );
    lastCameraPosition = _cameraPosition;
    _markers.add(
      Marker(
        markerId: MarkerId("cursor"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print(widget.address.labelAddress);
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Detail Address",
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Column(
            children: [
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Align(alignment: Alignment.centerLeft, child: Text("Alamat:")),
//            ),
//            Container(
//              width: double.infinity,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(5),
//                color: Colors.grey.shade200,
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(
//                  '$widget.address.name',
//                  style: TextStyle(fontSize: 12),
//                ),
//              ),
//            ),
              Divider(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    children: [
//                    Container(
//                        width: MediaQuery.of(context).size.width,
//                        height: MediaQuery.of(context).size.height * 0.2,
//                        child: GoogleMap(
//
//                          onMapCreated: _onMapCreated,
//                          initialCameraPosition: _cameraPosition,
//                          zoomControlsEnabled: false,
//                          markers: _markers,
//                          myLocationButtonEnabled: true,
//                          liteModeEnabled: true,
//                          tiltGesturesEnabled: false,
//                          zoomGesturesEnabled: false,
//
//                        )),
                      Divider(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                                label: 'Nama',
                                controller: _addressName,
                                marginTop: 20,
                                marginBottom: 0,
                                hint: "Home / Office / Rumah teman",
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Nama tidak boleh kosong";
                                  }
                                  return null;
                                }),
                            CustomTextField(
                                label: 'Detail Alamat',
                                controller: _detailedAddress,
                                marginTop: 20,
                                marginBottom: 0,
                                hint: 'Jalan, No Rumah, RT RW',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Recipient's name can't be empty";
                                  }
                                  return null;
                                }),
                            Container(
                                margin: EdgeInsets.only(top: 20, bottom: 5), child: Text("Provinsi", style: TextStyle(fontWeight: FontWeight.bold))),
                            BlocBuilder<ProvinceBloc, ProvinceState>(builder: (context, state) {
                              if (state is ProvinceInit) {
                                context.bloc<ProvinceBloc>().add(FetchProvince());
                              }
                              if (state is ProvinceReady) {
                                List<Province> datas = state.province;
                                List<DropdownMenuItem<String>> dropDownItem = datas.map<DropdownMenuItem<String>>((Province province) {
                                  return DropdownMenuItem<String>(
                                    value: province.name,
                                    child: Text(province.name),
                                  );
                                }).toList();

                                if (provinceValue == null) {
                                  provinceValue = datas[0].name;
                                  context.bloc<CityBloc>().add(FetchCity(provinceId: datas[0].id));
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        _unfocusText(context);
                                        Province selectedProvince = datas.firstWhere((element) => element.name == newValue);
                                        setState(() {
                                          provinceValue = newValue;
                                          cityValue = null;
                                          selectedCityId = null;
                                          subdistrictSelected = null;
                                          context.bloc<CityBloc>().add(FetchCity(provinceId: selectedProvince.id));
                                          context.bloc<SubDistrictBloc>().add(SelectSubDistrict(null));
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
                            Container(margin: EdgeInsets.only(top: 20, bottom: 5), child: Text("Kota", style: TextStyle(fontWeight: FontWeight.bold))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade200,
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
                                    child: BlocBuilder<CityBloc, CityState>(
                                      builder: (context, state) {
                                        if (state is CityEmpty) {
                                          return Container(
                                            child: Center(
                                              child: Text("Pilih provinsi terlebih dahulu"),
                                            ),
                                          );
                                        }
                                        if (state is CityLoading) {

                                          return Container(child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(child: CircularProgressIndicator()),
                                          ));
                                        }
                                        if (state is CityReady) {
                                          List<City> citiesData = state.cities;


                                          List<DropdownMenuItem<int>> dropDownItem = citiesData.map<DropdownMenuItem<int>>((City city) {
                                           print(city.name);
                                            return DropdownMenuItem<int>(
                                              value: int.parse(city.id),
                                              child: Text(city.name),
                                            );
                                          }).toList();


                                          cityValue = state.selectedCities;
                                          realCityValue = citiesData[0].realCityName;
                                          if(selectedCityId == null){
                                            selectedCityId = int.parse(citiesData[0].id);
                                            context.bloc<SubDistrictBloc>().add(FetchSubDistrict(cityId: selectedCityId.toString()));
                                          }
                                          var found = citiesData.where((element) => element.id == selectedCityId.toString()).toList();
                                          if(found.length == 0){
                                            selectedCityId = int.parse(citiesData[0].id);
                                            context.bloc<SubDistrictBloc>().add(FetchSubDistrict(cityId: selectedCityId.toString()));
                                          }
                                          return DropdownButton<int>(
                                            onChanged: (int newValue) {
                                              _unfocusText(context);
                                              setState(() {
                                                City selectedCity = citiesData.where((element) => int.parse(element.id) == newValue).first;
                                                selectedCityId = newValue;
                                                cityValue = selectedCity.name;
                                                selectedCity = selectedCity;
                                                realCityValue =selectedCity.realCityName;
                                                subdistrictSelected = null;
                                                context.bloc<CityBloc>().add(SelectCity(cityValue, realCityValue));
                                                context.bloc<SubDistrictBloc>().add(FetchSubDistrict(cityId: selectedCityId.toString()));
                                              });
                                            },
                                            value: selectedCityId,
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
                                margin: EdgeInsets.only(top: 20, bottom: 5),
                                child: Text("Kecamatan/Kelurahan", style: TextStyle(fontWeight: FontWeight.bold))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade200,
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
                                    child: BlocBuilder<SubDistrictBloc, SubDistrictState>(
                                      builder: (context, state) {
                                        if (state is SubDistrictEmpty) {
                                          return Container(
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Text("Pilih Kota terlebih dahulu"),
                                              ),
                                            ),
                                          );
                                        }
                                        if (state is SubDistrictLoading) {
                                          return Container(child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(child: CircularProgressIndicator()),
                                          ));
                                        }
                                        if (state is SubDistrictReady) {
                                          List<Subdistrict> subdistrictDatas = state.subdistrict;
                                          if(subdistrictSelected == null){
                                            subdistrictSelected = subdistrictDatas[0];
                                          }
                                          var selectedVal = subdistrictDatas.where((element) => element.subdistrictId == subdistrictSelected.subdistrictId).toList();
                                          if(selectedVal.length == 0){
                                            subdistrictSelected = subdistrictDatas[0];
                                          }
                                          print("0000: SELECTED IS");
                                          print(subdistrictSelected.subdistrictId);
                                          print("0000: Data is");
                                          print(jsonEncode(subdistrictDatas));
                                          List<DropdownMenuItem<Subdistrict>> dropDownItem =
                                          subdistrictDatas.map<DropdownMenuItem<Subdistrict>>((Subdistrict subdistrict) {
                                            return DropdownMenuItem<Subdistrict>(
                                              value: subdistrict,
                                              child: Text(subdistrict.subdistrictName),
                                            );
                                          }).toList();

                                          return DropdownButton<Subdistrict>(
                                            onChanged: (Subdistrict newValue) {
                                              _unfocusText(context);
                                              setState(() {
                                                subdistrictId = newValue.subdistrictId;
                                                subdistrictSelected = newValue;
                                                context.bloc<SubDistrictBloc>().add(SelectSubDistrict(subdistrictSelected));
                                              });
                                            },
                                            value: subdistrictSelected,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            items: dropDownItem,
                                            underline: Container(),
                                          );
                                        }
                                        return Container();
                                      },
                                    ))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      label: "Simpan",
                      onPressed: () {
                        saveAddress(context);
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
  void _unfocusText(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    TextEditingController().clear();
  }
  saveAddress(BuildContext context) {
    if (_formKey.currentState.validate()) {
      UserAddress address = UserAddress(
          name: _addressName.text,
//          namePerson: _recipientName.text,
//          phoneNumber: _recipientPhoneNumber.text,
          address: _detailedAddress.text,
//          labelAddress: widget.address.labelAddress,
          longitude: widget.address.longitude,
          latitude: widget.address.latitude,
          province: provinceValue,
//          city: cityValue,
          city: realCityValue,
          subdistrict: subdistrictSelected.subdistrictName,
          destination: subdistrictSelected.subdistrictId,
          selected: 1);
//          pinnedFromMap: true);
      if (widget.isUpdate) {
        address.id = widget.address.id;
        context.bloc<AddressBloc>().add(UpdateAddress(address: address));
      } else {
        context.bloc<AddressBloc>().add(AddAddress(address: address));
      }
      context.bloc<AddressBloc>().add(FetchAddress());
      Navigator.popUntil(context, ModalRoute.withName(AddressPage.tag));
    }
  }
}
