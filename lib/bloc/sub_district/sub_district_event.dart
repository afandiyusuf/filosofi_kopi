import 'package:equatable/equatable.dart';

class SubDistrictEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSubDistrict extends SubDistrictEvent {
  final String cityId;

  FetchSubDistrict({this.cityId});
}
class SelectSubDistrict extends SubDistrictEvent{
  final String selectedSubDistrict;
  final String realSubDistrictName;
  SelectSubDistrict(this.selectedSubDistrict,this.realSubDistrictName);
}
