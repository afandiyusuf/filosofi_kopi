import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProductCart extends CartProductEvent {
  final Product product;
  final int total;
  final String store;

  UpdateProductCart(
      {@required this.product, @required this.total, @required this.store});
}

class DeleteProductItemFromCart extends CartProductEvent {
  final String cartId;
  final String store;

  DeleteProductItemFromCart({this.cartId, this.store});
}

class FetchCart extends CartProductEvent {
  final String location;

  FetchCart({this.location});
}

class UpdateDeliveryMethodCart extends CartProductEvent {
  final Gosend deliverySelected;

  UpdateDeliveryMethodCart({this.deliverySelected});
}

class DisposeCartEvent extends CartProductEvent {}

class AddTransaction extends CartProductEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String addressId;
  final String shipping;
  final String shippingType;
  final String shippingCost;
  final String voucher;
  final String latitude;
  final String longitude;
  final String store;

  AddTransaction({
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.addressId,
      this.shipping,
      this.shippingType,
      this.shippingCost,
      this.voucher,
      this.latitude,
      this.longitude,
      this.store});
}
