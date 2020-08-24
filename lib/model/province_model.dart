class Province{
  final String id;
  final String name;

  Province({this.id, this.name});
  factory Province.fromJson(Map<String, dynamic> map){
    return Province(
      id: map['province_id'],
      name: map['province']
    );
  }
}