import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressModel {
  List<UserAddress> _allAddress;
  int lastId = 99;
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  List<UserAddress> get allAddress => _allAddress;

  UserAddressModel() {
    loadAddress();
  }

  select(String id) {
    print("SELECT");
    for (int i = 0; i < _allAddress.length; i++) {
      print("SELECTED CHANGE 0");
      _allAddress[i].selected = 0;
      if (_allAddress[i].id == id) {
        print("SELECTED CHANGE 1");
        _allAddress[i].selected = 1;
      }
    }
    saveAddress();
  }

  addAddress(UserAddress address) async {
    SharedPreferences pref = await _pref;
    final body = {
      'token': pref.getString("token"),
      'name': address.name,
      'province': address.province,
      'city': address.city,
      'subdistrict': address.subdistrict,
      'destination': address.destination,
      'address': address.address,
      'latitude': address.latitude,
      'longitude': address.longitude
    };
    var response = await http.post('https://filosofikopi.id/restApi/add_address', body: body);
    if (response.statusCode == 200) {
      AddressResponse addressResponse = AddressResponse.fromJson(jsonDecode(response.body));
      _allAddress = addressResponse.data;
    } else {
      _allAddress = [];
    }
    loadAddress();
  }

  Future<void> removeAddress(UserAddress address) async {
    SharedPreferences pref = await _pref;
    final body = {'token': pref.getString('token'), 'id': address.id};
    await http.post('https://filosofikopi.id/restApi/delete_user_address', body: body);
    await loadAddress();
    return;
  }

  updateAddress(UserAddress address) async {
    SharedPreferences pref = await _pref;
    final body = {
      'id' : address.id,
      'token': pref.getString("token"),
      'name': address.name,
      'province': address.province,
      'city': address.city,
      'subdistrict': address.subdistrict,
      'destination': address.destination,
      'address': address.address,
      'latitude': address.latitude,
      'longitude': address.longitude
    };
    await http.post('https://filosofikopi.id/restApi/update_user_address', body: body);
    await loadAddress();
  }

  int getId() {
    lastId += 1;
    return lastId;
  }

  //address url
  loadAddress() async {
    SharedPreferences pref = await _pref;
    final body = {'token': pref.getString('token')};
    var response = await http.post('https://filosofikopi.id/restApi/get_user_address', body: body);
    if (response.statusCode == 200) {
      AddressResponse addressResponse = AddressResponse.fromJson(jsonDecode(response.body));
      _allAddress = addressResponse.data;
    } else {
      _allAddress = [];
    }
  }

  saveAddress() async {
//    SharedPreferences pref = await _pref;
//    if (_allAddress != null) {
//      var json = jsonEncode(_allAddress);
//      print("Address is");
//      print(json);
//      pref.setString('addresses', json);
//    }
  }
}

// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

class AddressResponse {
  AddressResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  final int status;
  final bool success;
  final String msg;
  final List<UserAddress> data;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
        status: json["status"] == null ? null : json["status"],
        success: json["success"] == null ? null : json["success"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : List<UserAddress>.from(json["data"].map((x) => UserAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "success": success == null ? null : success,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserAddress {
  UserAddress(
      {this.id,
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
      this.selected});

  String id;
  final String userId;
  final String name;
  final String province;
  final String city;
  final String subdistrict;
  final String destination;
  String address;
  String latitude;
  String longitude;
  final String token;
  int selected = 0;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        province: json["province"] == null ? null : json["province"],
        city: json["city"] == null ? null : json["city"],
        subdistrict: json["subdistrict"] == null ? null : json["subdistrict"],
        destination: json["destination"] == null ? null : json["destination"],
        address: json["address"] == null ? null : json["address"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "province": province == null ? null : province,
        "city": city == null ? null : city,
        "subdistrict": subdistrict == null ? null : subdistrict,
        "destination": destination == null ? null : destination,
        "address": address == null ? null : address,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "token": token == null ? null : token,
      };
}

//UserAddress userAddressFromJson(String str) => UserAddress.fromJson(json.decode(str));
//
//String userAddressToJson(UserAddress data) => json.encode(data.toJson());
//
//class UserAddress {
//  UserAddress({
//    this.id,
//    this.userId,
//    this.name,
//    this.province,
//    this.city,
//    this.subdistrict,
//    this.destination,
//    this.address,
//    this.latitude,
//    this.longitude,
//    this.token,
//    this.selected,
//  });
//
//  String id;
//  String userId;
//  String name;
//  String province;
//  String city;
//  String subdistrict;
//  String destination;
//  String address;
//  double latitude;
//  double longitude;
//  String token;
//  int selected;
//
//  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
//    id: json["id"],
//    userId: json["user_id"],
//    name: json["name"],
//    province: json["province"],
//    city: json["city"],
//    subdistrict: json["subdistrict"],
//    destination: json["destination"],
//    address: json["address"],
//    latitude: double.parse(json["latitude"]),
//    longitude: double.parse(json["longitude"]),
//    token: json["token"],
//    selected: 0
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "user_id": userId,
//    "name": name,
//    "province": province,
//    "city": city,
//    "subdistrict": subdistrict,
//    "destination": destination,
//    "address": address,
//    "latitude":  latitude,
//    "longitude": longitude,
//    "token": token,
//  };
//}
