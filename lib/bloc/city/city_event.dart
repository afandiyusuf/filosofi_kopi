import 'package:equatable/equatable.dart';

class CityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCity extends CityEvent {
  final String provinceId;

  FetchCity({this.provinceId});
}
class SelectCity extends CityEvent{
  final String selectedCity;
  final String realCityName;
  SelectCity(this.selectedCity,this.realCityName);
}
