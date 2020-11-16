import 'package:filkop_mobile_apps/model/category_apparel_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CategoryApparelRepository{
  final ApiService apiService;
  CategoryApparelRepository({@required this.apiService});

  Future<CategoryApparelModel> getCategoryApparelModel() async{
    CategoryApparelModel categoryProductModel = await apiService.getCategoryApparelModel();
    return categoryProductModel;
  }
}