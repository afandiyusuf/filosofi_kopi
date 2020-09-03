import 'package:filkop_mobile_apps/model/product_model.dart';

class OrderBoxModel{
  static const int AMBIL_SENDIRI = 0;
  static const int DIKIRIM = 1;
  int stateButton;
  String location;
  int storeId;
  String state = "default";
  Product selectedProduct;
  int selectedTotal = 0;
  int initialSelectedTotal = 0;
  OrderBoxModel({this.stateButton, this.location, this.storeId = 0});
  factory OrderBoxModel.fromJson(dynamic map){
    return OrderBoxModel(
      stateButton : int.parse(map['stateButton']),
      location : map['location'],
      storeId: map['storeId']
    );
  }

  String toJson(){
    return '{"storeId":$storeId,"location":"$location","state":"$state",}';
  }
}