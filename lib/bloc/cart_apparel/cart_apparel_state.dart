import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:flutter/cupertino.dart';

class CartApparelState extends Equatable{
  @override
  List<Object> get props => [];
}
class CartInitState extends CartApparelState{}
class CartEmptyState extends CartApparelState{}

class CartUpdated extends CartApparelState{
  final CartApparelModel cartModel;

  CartUpdated({@required this.cartModel});
}
class CartUpdating extends CartApparelState{}

class CartUpdateError extends CartApparelState{
  final CartApparelModel cartModel;

  CartUpdateError({@required this.cartModel});
}

class AddingTransaction extends CartApparelState{}

class AddTransactionSuccess extends CartApparelState{}

class AddTransactionError extends CartApparelState{
  final String message;
  AddTransactionError(this.message);
}

class DeleteItemSuccess extends CartApparelState{}