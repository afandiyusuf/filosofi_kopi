import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class UpdateCart extends CartEvent{
  final Product product;
  final int total;
  final String store;
  UpdateCart({@required this.product, @required this.total, @required this.store});
}

class DisposeCartEvent extends CartEvent{}

