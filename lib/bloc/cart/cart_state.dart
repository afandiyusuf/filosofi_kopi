import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartState extends Equatable{
  @override
  List<Object> get props => [];
}
class CartInitState extends CartState{}
class CartEmptyState extends CartState{}

class CartUpdated extends CartState{
  final CartModel cartModel;

  CartUpdated({@required this.cartModel});
}
class CartUpdating extends CartState{}

class CartUpdateError extends CartState{
  final CartModel cartModel;

  CartUpdateError({@required this.cartModel});
}