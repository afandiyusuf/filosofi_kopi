import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProductState extends Equatable{
  @override
  List<Object> get props => [];
}
class CartInitState extends CartProductState{}
class CartEmptyState extends CartProductState{}

class CartUpdated extends CartProductState{
  final CartProductModel cartModel;

  CartUpdated({@required this.cartModel});
}
class CartUpdating extends CartProductState{}

class CartUpdateError extends CartProductState{
  final CartProductModel cartModel;

  CartUpdateError({@required this.cartModel});
}

class AddingTransaction extends CartProductState{}

class AddTransactionSuccess extends CartProductState{}

class AddTransactionError extends CartProductState{
  final String message;
  AddTransactionError(this.message);
}

class DeleteItemSuccess extends CartProductState{}