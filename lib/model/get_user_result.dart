// To parse this JSON data, do
//
//     final getUserResult = getUserResultFromJson(jsonString);

import 'dart:convert';

GetUserResult getUserResultFromJson(String str) =>
    GetUserResult.fromJson(json.decode(str));

String getUserResultToJson(GetUserResult data) => json.encode(data.toJson());

class GetUserResult {
  GetUserResult({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int status;
  bool success;
  String msg;
  GetUserResultData data;

  factory GetUserResult.fromJson(Map<String, dynamic> json) => GetUserResult(
        status: json["status"] == null ? null : json["status"],
        success: json["success"] == null ? null : json["success"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : GetUserResultData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "success": success == null ? null : success,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
      };
}

class GetUserResultData {
  GetUserResultData({
    this.success,
    this.data,
  });

  bool success;
  UserProfile data;

  factory GetUserResultData.fromJson(Map<String, dynamic> json) =>
      GetUserResultData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : UserProfile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class UserProfile {
  UserProfile({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.dob,
    this.pob,
    this.phone,
  });

  String id;
  String email;
  String firstName;
  dynamic lastName;
  DateTime dob;
  dynamic pob;
  String phone;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        pob: json["pob"] == null ? null : json["pob"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "pob": pob == null ? null : pob,
        "phone": phone == null ? null : phone,
      };
}
