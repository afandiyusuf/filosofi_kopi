import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:flutter/cupertino.dart';

abstract class StoreSelectedState extends Equatable{
  const StoreSelectedState();
  @override
  List<Object> get props => [];
}

class StoreSelectedEmpty extends StoreSelectedState {}

class StoreSelectedUpdated extends StoreSelectedState{
  final Store store;
  StoreSelectedUpdated({@required this.store}) : assert(store != null);
}