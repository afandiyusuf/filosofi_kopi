import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CartRepository {
  final ApiService apiService;

  CartRepository({@required this.apiService});

  Future<bool> addToCartFnb(String productId, String total, String store,
      String notes) {
    return apiService.addToCart(productId, total, notes, store);
  }

  Future<CartProductModel> getCart(String store) {
    return apiService.getCart(store);
  }

  Future<bool> deleteItemFromCart(String cartId) {
    return apiService.deleteItemFromCart(cartId);
  }

  Future<List<Gosend>> getGosendData(String store, double long, double lat) {
    return apiService.getGosendService(store, lat, long);
  }

  Future<String> addTransactionFnb(String firstName,
      String lastName,
      String email,
      String phone,
      String addressId,
      String shipping,
      String shippingType,
      String shippingCost,
      String voucher,
      String latitude,
      String longitude,
      String store) {
    return apiService.addTransactionFnb(
        firstName,
        lastName,
        email,
        phone,
        addressId,
        shipping,
        shippingType,
        shippingCost,
        voucher,
        latitude,
        longitude,
        store);
  }

}