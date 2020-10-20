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

  select(String id) {
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
      _allAddress.forEach((element) {
        if(lastId <= int.parse(element.id)){
          lastId = int.parse(element.id)+1;
        }
      });
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
UserAddress userAddressFromJson(String str) => UserAddress.fromJson(json.decode(str));

String userAddressToJson(UserAddress data) => json.encode(data.toJson());

class UserAddress {
  UserAddress({
    this.id,
    this.userId,
    this.name,
    this.province,
    this.city,
    this.subdistrict,
    this.destination,
    this.address,
    this.latitude,
    this.longitude,
    this.token,
    this.selected,
  });

  String id;
  String userId;
  String name;
  String province;
  String city;
  String subdistrict;
  String destination;
  String address;
  double latitude;
  double longitude;
  String token;
  int selected;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    province: json["province"],
    city: json["city"],
    subdistrict: json["subdistrict"],
    destination: json["destination"],
    address: json["address"],
    latitude: double.parse(json["latitude"]),
    longitude: double.parse(json["longitude"]),
    token: json["token"],
    selected: 0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "province": province,
    "city": city,
    "subdistrict": subdistrict,
    "destination": destination,
    "address": address,
    "latitude":  latitude,
    "longitude": longitude,
    "token": token,
  };
}

