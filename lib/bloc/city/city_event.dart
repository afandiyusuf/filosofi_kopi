import 'package:equatable/equatable.dart';

class CityEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCity extends CityEvent {
  final String province_id;

  FetchCity({this.province_id});
}
