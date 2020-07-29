import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/order_box.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderBoxEvent extends Equatable{
  const OrderBoxEvent();
}

class OrderBoxUpdate extends OrderBoxEvent{
  final OrderBox orderBox;
  OrderBoxUpdate({this.orderBox});

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderBoxUpdateLocation extends OrderBoxEvent{
  final String location;
  OrderBoxUpdateLocation({@required this.location});

  @override
  List<Object> get props => [];
}