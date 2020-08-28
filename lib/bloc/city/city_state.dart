import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';

class CityState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CityEmpty extends CityState {}

class CityLoading extends CityState {}

class CityReady extends CityState {
  final List<City> cities;
  final String selectedCities;
  final String realCityName;
  CityReady({this.cities, this.selectedCities,this.realCityName});
}


class CityError extends CityState {
  final String message;

  CityError(this.message);
}
