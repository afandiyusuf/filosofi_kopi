import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderBoxEvent extends Equatable{
  const OrderBoxEvent();
}

class OrderBoxUpdate extends OrderBoxEvent{
  final OrderBoxModel orderBox;
  OrderBoxUpdate({this.orderBox});

  @override
  List<Object> get props => [];
}

class OrderBoxUpdateLocation extends OrderBoxEvent{
  final String location;
  final int storeId;
  OrderBoxUpdateLocation({@required this.location, @required this.storeId});

  @override
  List<Object> get props => [];
}

class OrderBoxUpdateStateButton extends OrderBoxEvent{
  final int stateButton;
  OrderBoxUpdateStateButton({@required this.stateButton});
  @override
  List<Object> get props => [];
}

class OrderBoxSelectProduct extends OrderBoxEvent{
  final Product selectedProduct;
  final int total;
  OrderBoxSelectProduct({@required this.selectedProduct, this.total = 0});
  @override
  List<Object> get props => [];
}
class OrderBoxUnselectProduct extends OrderBoxEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderBoxSetTotalSelectedProduct extends OrderBoxEvent{
  final int total;

  OrderBoxSetTotalSelectedProduct({this.total});

  @override
  // TODO: implement props
  List<Object> get props => [];
}