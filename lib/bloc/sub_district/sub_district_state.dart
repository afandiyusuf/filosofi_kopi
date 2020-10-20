import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';

class SubDistrictState extends Equatable {
  @override
  List<Object> get props => [];
}

class SubDistrictEmpty extends SubDistrictState {}

class SubDistrictLoading extends SubDistrictState {}

class SubDistrictReady extends SubDistrictState {
  final List<City> cities;
  final String selectedCities;
  final String realCityName;
  SubDistrictReady({this.cities, this.selectedCities,this.realCityName});
}


class SubDistrictError extends SubDistrictState {
  final String message;

  SubDistrictError(this.message);
}
