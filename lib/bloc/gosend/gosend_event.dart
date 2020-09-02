import 'package:equatable/equatable.dart';

class GosendEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchGosend extends GosendEvent{

  @override
  // TODO: implement props
  List<Object> get props => [];
  final String store;
  final double long;
  final double lat;
  FetchGosend({this.store, this.long, this.lat});
}

class PickGosend extends GosendEvent{
  final String type;
  PickGosend(this.type);
}