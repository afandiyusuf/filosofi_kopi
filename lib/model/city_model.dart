class City {
  final String id;
  final String type;
  final String name;
  final String realCityName;
  final String postalCode;

  City({this.id, this.type, this.name, this.postalCode, this.realCityName});
  factory City.fromJson(dynamic map) {
    return City(
        id: map['city_id'],
        type: map['type'],
        name:'${map['type']} ${map['city_name']}',
        realCityName: map['city_name'],
        postalCode: map['postal_code']);
  }
}
