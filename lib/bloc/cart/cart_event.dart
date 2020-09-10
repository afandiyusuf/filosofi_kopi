import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateCart extends CartEvent {
  final Product product;
  final int total;
  final String store;

  UpdateCart(
      {@required this.product, @required this.total, @required this.store});
}

class DeleteItemFromCart extends CartEvent {
  final String cartId;
  final String store;

  DeleteItemFromCart({this.cartId, this.store});
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
  final String address;
  final String phone;
  final String subtotal;
  final String totalAmount;
  final String total;
  final String discount;
  final String shipping;
  final String shippingType;
  final String shippingCost;
  final String shippingOrigin;
  final String shippingDestination;
  final String province;
  final String city;
  final String voucher;
  final String latitude;
  final String longitude;
  final String createdDate;
  final String store;

  AddTransaction(
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.phone,
      this.subtotal,
      this.totalAmount,
      this.total,
      this.discount,
      this.shipping,
      this.shippingType,
      this.shippingCost,
      this.shippingOrigin,
      this.shippingDestination,
      this.province,
      this.city,
      this.voucher,
      this.latitude,
      this.longitude,
      this.createdDate,
      this.store);
}
