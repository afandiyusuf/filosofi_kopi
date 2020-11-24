import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';

class OrderBoxModel{
  static const int AMBIL_SENDIRI = 0;
  static const int DIKIRIM = 1;
  int stateButton;
  String location;
  int storeId;
  String state = "default";
  Product selectedProduct;
  Apparel selectedApparel;
  int selectedApparelTotal = 0;
  int selectedProductTotal = 0;
  int initialSelectedProductTotal = 0;
  int initialSelectedApparelTotal = 0;
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