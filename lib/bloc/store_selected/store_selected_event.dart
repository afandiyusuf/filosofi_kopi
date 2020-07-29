import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';

abstract class StoreSelectedEvent extends Equatable{
  const StoreSelectedEvent();
}

class UpdateStoreSelected extends StoreSelectedEvent{
  const UpdateStoreSelected({this.store});
  final Store store;

  @override
  List<Object> get props => [];
}