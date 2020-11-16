import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class ProductRepository{
  final ApiService apiService;
  ProductRepository({@required this.apiService});

  Future<ProductModel> getProductModelByStore(String store) async{
    ProductModel products = await apiService.getProductModelByStore({
      "store":store
    });

    return products;
  }
}