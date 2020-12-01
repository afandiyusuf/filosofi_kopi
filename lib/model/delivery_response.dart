import 'dart:convert';

DeliveryResponse deliveryResponseFromJson(String str) => DeliveryResponse.fromJson(json.decode(str));

String deliveryResponseToJson(DeliveryResponse data) => json.encode(data.toJson());

class DeliveryResponse {
  DeliveryResponse({
    this.rajaongkir,
  });

  Rajaongkir rajaongkir;

  factory DeliveryResponse.fromJson(Map<String, dynamic> json) => DeliveryResponse(
    rajaongkir: json["rajaongkir"] == null ? null : Rajaongkir.fromJson(json["rajaongkir"]),
  );

  Map<String, dynamic> toJson() => {
    "rajaongkir": rajaongkir == null ? null : rajaongkir.toJson(),
  };
}

class Rajaongkir {
  Rajaongkir({
    this.status,
    this.destinationDetails,
    this.results,
  });

  Status status;
  DestinationDetails destinationDetails;
  List<Result> results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    destinationDetails: json["destination_details"] == null ? null : DestinationDetails.fromJson(json["destination_details"]),
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status.toJson(),
    "destination_details": destinationDetails == null ? null : destinationDetails.toJson(),
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class DestinationDetails {
  DestinationDetails({
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });

  String subdistrictId;
  String provinceId;
  String province;
  String cityId;
  String city;
  String type;
  String subdistrictName;

  factory DestinationDetails.fromJson(Map<String, dynamic> json) => DestinationDetails(
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
}

class Result {
  Result({
    this.code,
    this.name,
    this.costs,
  });

  String code;
  String name;
  List<Delivery> costs;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    costs: json["costs"] == null ? null : List<Delivery>.from(json["costs"].map((x) => Delivery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "name": name == null ? null : name,
    "costs": costs == null ? null : List<dynamic>.from(costs.map((x) => x.toJson())),
  };
}

class Delivery {
  Delivery({
    this.service,
    this.description,
    this.cost,
  });

  String service;
  String description;
  List<DeliveryCost> cost;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    service: json["service"] == null ? null : json["service"],
    description: json["description"] == null ? null : json["description"],
    cost: json["cost"] == null ? null : List<DeliveryCost>.from(json["cost"].map((x) => DeliveryCost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "service": service == null ? null : service,
    "description": description == null ? null : description,
    "cost": cost == null ? null : List<dynamic>.from(cost.map((x) => x.toJson())),
  };
}

class DeliveryCost {
  DeliveryCost({
    this.value,
    this.etd,
    this.note,
  });

  int value;
  String etd;
  String note;

  factory DeliveryCost.fromJson(Map<String, dynamic> json) => DeliveryCost(
    value: json["value"] == null ? null : json["value"],
    etd: json["etd"] == null ? null : json["etd"],
    note: json["note"] == null ? null : json["note"],
  );

  Map<String, dynamic> toJson() => {
    "value": value == null ? null : value,
    "etd": etd == null ? null : etd,
    "note": note == null ? null : note,
  };
}

class Status {
  Status({
    this.code,
    this.description,
  });

  int code;
  String description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "description": description == null ? null : description,
  };
}
