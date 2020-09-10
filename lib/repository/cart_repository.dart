import 'package:filkop_mobile_apps/model/cart_model.dart';
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

  Future<CartModel> getCart(String store) {
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
      String address,
      String phone,
      String subtotal,
      String totalAmount,
      String total,
      String discount,
      String shipping,
      String shippingType,
      String shippingCost,
      String shippingOrigin,
      String shippingDestination,
      String province,
      String city,
      String voucher,
      String latitude,
      String longitude,
      String createdDate,
      String store) {
    return apiService.addTransactionFnb(
        firstName,
        lastName,
        email,
        address,
        phone,
        subtotal,
        totalAmount,
        total,
        discount,
        shipping,
        shippingType,
        shippingCost,
        shippingOrigin,
        shippingDestination,
        province,
        city,
        voucher,
        latitude,
        longitude,
        createdDate,
        store);
  }

}