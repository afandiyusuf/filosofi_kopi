import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CartApparelRepository {
  final ApiService apiService;

  CartApparelRepository({@required this.apiService});

  Future<bool> addToCartApparel(String productId, String total, String store,
      String notes, String size) {
    return apiService.addToCartApparel(productId, total, notes, store, size);
  }

  Future<CartApparelModel> getCart(String store) {
    return apiService.getCartApparel(store);
  }

  Future<bool> deleteItemFromCart(String cartId) {
    return apiService.deleteItemFromCartApparel(cartId);
  }
  Future<bool> deleteItemApparelFromCart(String cartId) {
    return apiService.deleteItemApparelFromCartApparel(cartId);
  }

  Future<List<Gosend>> getGosendData(String store, double long, double lat) {
    return apiService.getGosendService(store, lat, long);
  }

  Future<String> addTransactionApparel(String firstName,
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
    return apiService.addTransactionApparel(
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