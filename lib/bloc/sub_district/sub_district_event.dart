import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/subdistrict.dart';

class SubDistrictEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSubDistrict extends SubDistrictEvent {
  final String cityId;

  FetchSubDistrict({this.cityId});
}
class SelectSubDistrict extends SubDistrictEvent{
  final Subdistrict selectedSubdistrict;
  SelectSubDistrict(this.selectedSubdistrict);
}
