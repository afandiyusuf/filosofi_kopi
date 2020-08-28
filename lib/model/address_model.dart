import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressModel {
  List<UserAddress> _allAddress;
  int lastId = 99;
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  List<UserAddress> get allAddress => _allAddress;

  UserAddressModel(){
    loadAddress();
  }

  select(int id) {
    print("SELECT");
    for(int i= 0;i<_allAddress.length;i++){
      print("SELECTED CHANGE 0");
      _allAddress[i].selected = 0;
      if(_allAddress[i].id == id){
        print("SELECTED CHANGE 1");
        _allAddress[i].selected = 1;
      }
    }
    _allAddress.sort((a,b) => b.selected.compareTo(a.selected));
    saveAddress();
  }

  addAddress(UserAddress address) {
    _allAddress.add(address);
    select(address.id);
    saveAddress();
  }

  removeAddress(UserAddress address) {
    _allAddress.remove(address);
    if(address.selected == 1){
      if(_allAddress.length > 0){
        allAddress[0].selected = 1;
      }
    }
    saveAddress();
  }

  updateAddress(UserAddress address) {
    for(var i=0;i<_allAddress.length;i++){
      if(_allAddress[i].id == address.id){
        _allAddress.removeAt(i);
      }
    }
    addAddress(address);
  }

  int getId() {
    lastId += 1;
    return lastId;
  }

  loadAddress() async {
    SharedPreferences pref = await _pref;
    print(pref.getString('addresses') );
    if (pref.getString('addresses') != null) {
      var parsed = pref.getString('addresses');
      var data = jsonDecode(parsed);
      _allAddress = List<UserAddress>.from(
          data.map((item) => UserAddress.fromJson(item)));
    }else{
      _allAddress = [];
    }
    print(_allAddress);
  }

  saveAddress() async {
    SharedPreferences pref = await _pref;
    if (_allAddress != null) {
      var json = jsonEncode(_allAddress);
      print("Address is");
      print(json);
      pref.setString('addresses', json);
    }
  }
}

class UserAddress {
  int id;
  String title;
  String namePerson;
  String phoneNumber;
  String detailAddress;
  double longitude;
  double latitude;
  String province;
  String realCity;
  String city;
  int selected;
  bool pinnedFromMap;
  String labelAddress;

  UserAddress(
      {this.id,
      this.title,
      this.namePerson,
      this.phoneNumber,
      this.detailAddress,
      this.longitude,
      this.latitude,
      this.selected,
      this.province,
      this.city,
      this.labelAddress,
      this.realCity,
      this.pinnedFromMap});

  factory UserAddress.fromJson(dynamic map) {
    return UserAddress(
        id: map['id'],
        title: map['title'],
        namePerson: map['namePerson'],
        phoneNumber: map['phoneNumber'],
        detailAddress: map['detailAddress'],
        labelAddress: map['labelAddress'],
        longitude: map['longitude'],
        province: map['province'],
        city: map['city'],
        realCity: map['realCity'],
        latitude: map['latitude'],
        selected: map['selected'],
        pinnedFromMap: map['pinnedFromMap']);
  }

  Map toJson() => {
        'title': title,
        'namePerson': namePerson,
        'phoneNumber': phoneNumber,
        'detailAddress': detailAddress,
        'longitude': longitude,
        'latitude': latitude,
        'selected': selected,
        'pinnedFromMap': pinnedFromMap,
        'province': province,
        'city': city,
        'labelAddress': labelAddress,
        'realCity': realCity,
        'id': id,
      };
}
