import 'dart:convert';

class UserModel{
  int id;
  String name;
  String email;
  int age;
  UserModel({this.id,this.name, this.email, this.age});
  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
      id: map['id'], name:map['name'], email: map['email'], age:map['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {"id":id, "name":name, "email":email, "age":age};
  }

  @override
  String toString(){
    return 'Profile{id: $id, name:$name, email:$email, age:$age';
  }
}

List<UserModel> profileFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<UserModel>.from(data.map((item)=> UserModel.fromJson(item)));
}

String profileToJson(UserModel data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}