import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CartRepository{
  final ApiService apiService;
  CartRepository({@required this.apiService});

  Future<bool> addToCartFnb(String userId,String productId, String total, String store, String notes){
    return apiService.addToCart(userId,productId,total,notes,store);
  }
}

