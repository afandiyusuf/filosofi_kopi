import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderBoxEvent extends Equatable{
  const OrderBoxEvent();
  List<Object> get props => [];
}

class OrderBoxUpdate extends OrderBoxEvent{
  final OrderBoxModel orderBox;
  OrderBoxUpdate({this.orderBox});
}

class OrderBoxUpdateLocation extends OrderBoxEvent{
  final String location;
  final int storeId;
  OrderBoxUpdateLocation({@required this.location, @required this.storeId});
}

class OrderBoxUpdateStateButton extends OrderBoxEvent{
  final int stateButton;
  OrderBoxUpdateStateButton({@required this.stateButton});
}

class OrderBoxSelectProduct extends OrderBoxEvent{
  final Product selectedProduct;
  final int total;
  OrderBoxSelectProduct({@required this.selectedProduct, this.total = 0});
}
class OrderBoxUnselectProduct extends OrderBoxEvent{
}

class OrderBoxSetTotalSelectedProduct extends OrderBoxEvent{
  final int total;

  OrderBoxSetTotalSelectedProduct({this.total});
}

class OrderBoxSelectApparel extends OrderBoxEvent{
  final Apparel selectedApparel;
  final int total;
  OrderBoxSelectApparel({@required this.selectedApparel, this.total = 0});
}
class OrderBoxUnselectApparel extends OrderBoxEvent{}

class OrderBoxSetTotalSelectedApparel extends OrderBoxEvent{
  final int total;
  OrderBoxSetTotalSelectedApparel({this.total});
}