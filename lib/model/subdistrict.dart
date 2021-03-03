import 'dart:convert';

import 'package:equatable/equatable.dart';

Subdistrict subdistrictFromJson(String str) => Subdistrict.fromJson(json.decode(str));

String subdistrictToJson(Subdistrict data) => json.encode(data.toJson());

class Subdistrict extends Equatable{
  Subdistrict({
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });

  final String subdistrictId;
  final String provinceId;
  final String province;
  final String cityId;
  final String city;
  final String type;
  final String subdistrictName;

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
    subdistrictId: json["subdistrict_id"] == null ? null : json["subdistrict_id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    province: json["province"] == null ? null : json["province"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    city: json["city"] == null ? null : json["city"],
    type: json["type"] == null ? null : json["type"],
    subdistrictName: json["subdistrict_name"] == null ? null : json["subdistrict_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdistrict_id": subdistrictId == null ? null : subdistrictId,
    "province_id": provinceId == null ? null : provinceId,
    "province": province == null ? null : province,
    "city_id": cityId == null ? null : cityId,
    "city": city == null ? null : city,
    "type": type == null ? null : type,
    "subdistrict_name": subdistrictName == null ? null : subdistrictName,
  };

  @override
  // TODO: implement props
  List<Object> get props => [this.subdistrictId];
}