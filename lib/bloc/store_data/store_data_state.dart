import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:flutter/cupertino.dart';

abstract class StoreDataState extends Equatable{
  const StoreDataState();
  @override
  List<Object> get props => [];
}

class StoreDataEmpty extends StoreDataState {}
class StoreDataLoading extends StoreDataState {}

class StoreDataLoaded extends StoreDataState {
  final StoreDatas storeDatas;
  const StoreDataLoaded({@required this.storeDatas}) : assert(storeDatas != null);

  @override
  List<Object> get props => [storeDatas];
}

class StoreDataError extends StoreDataState {}