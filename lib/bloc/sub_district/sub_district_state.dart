import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/subdistrict.dart';

class SubDistrictState extends Equatable {
  @override
  List<Object> get props => [];
}

class SubDistrictEmpty extends SubDistrictState {}

class SubDistrictLoading extends SubDistrictState {}

class SubDistrictReady extends SubDistrictState {
  final List<Subdistrict> subdistrict;
  final Subdistrict selectedSubdistrict;
  SubDistrictReady({this.subdistrict, this.selectedSubdistrict});
}


class SubDistrictError extends SubDistrictState {
  final String message;

  SubDistrictError(this.message);
}
