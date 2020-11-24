import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProductCart extends CartEvent {
  final Product product;
  final int total;
  final String store;

  UpdateProductCart(
      {@required this.product, @required this.total, @required this.store});
}

class UpdateApparelCart extends CartEvent {
  final Apparel product;
  final int total;
  final String store;

  UpdateApparelCart(
      {@required this.product, @required this.total, @required this.store});
}

class DeleteProductItemFromCart extends CartEvent {
  final String cartId;
  final String store;

  DeleteProductItemFromCart({this.cartId, this.store});
}

class DeleteApparelItemFromCart extends CartEvent {
  final String cartId;
  final String store;
  DeleteApparelItemFromCart({this.cartId, this.store});
}


class FetchCart extends CartEvent {
  final String location;

  FetchCart({this.location});
}

class UpdateDeliveryMethodCart extends CartEvent {
  final Gosend deliverySelected;

  UpdateDeliveryMethodCart({this.deliverySelected});
}

class DisposeCartEvent extends CartEvent {}

class AddTransaction extends CartEvent {
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
