import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class ApparelRepository{
  final ApiService apiService;
  ApparelRepository({@required this.apiService});

  Future<ApparelModel> getProductModelByStore(String store) async{
    ApparelModel products = await apiService.getApparelModel({
      "store":store
    });

    return products;
  }
}