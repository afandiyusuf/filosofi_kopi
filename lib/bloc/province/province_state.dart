import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/province_model.dart';

class ProvinceState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProvinceInit extends ProvinceState {}

class ProvinceReady extends ProvinceState {
  final List<Province> province;
  ProvinceReady(this.province);
}

class ProvinceError extends ProvinceState {
  final String message;

  ProvinceError(this.message);
}

class ProvinceLoading extends ProvinceState {}
