import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CategoryProductRepository{
  final ApiService apiService;
  CategoryProductRepository({@required this.apiService});

  Future<CategoryProductModel> getCategoryProductModel() async{
    CategoryProductModel categoryProductModel = await apiService.getCategoryProductModel();
    return categoryProductModel;
  }
}