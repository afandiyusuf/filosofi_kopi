import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/delivery_response.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartApparelEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProductCart extends CartApparelEvent {
  final Product product;
  final int total;
  final String store;

  UpdateProductCart(
      {@required this.product, @required this.total, @required this.store});
}

class UpdateApparelCart extends CartApparelEvent {
  final Apparel product;
  final int total;
  final String store;
  final String size;
  final String cartId;

  UpdateApparelCart(
      {@required this.product, @required this.total, @required this.store, this.size,this.cartId});
}


class DeleteApparelItemFromCart extends CartApparelEvent {
  final String cartId;
  final String store;
  DeleteApparelItemFromCart({this.cartId, this.store});
}


class FetchCart extends CartApparelEvent {
  final String location;

  FetchCart({this.location});
}

class UpdateDeliveryMethodCart extends CartApparelEvent {
  final Delivery deliverySelected;
  final Result deliveryResultSelected;

  UpdateDeliveryMethodCart({this.deliverySelected, this.deliveryResultSelected});
}

class DisposeCartEvent extends CartApparelEvent {}

class AddTransaction extends CartApparelEvent {
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
