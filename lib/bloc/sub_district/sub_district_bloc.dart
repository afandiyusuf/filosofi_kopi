import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_event.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_state.dart';
import 'package:filkop_mobile_apps/model/subdistrict.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubDistrictBloc extends Bloc<SubDistrictEvent, SubDistrictState> {
  final RajaOngkirRepository rajaOngkirRepository;
  List<Subdistrict> allSubdistrict;
  SubDistrictBloc({this.rajaOngkirRepository}) : super(SubDistrictEmpty());

  @override
  Stream<SubDistrictState> mapEventToState(SubDistrictEvent event) async* {
    yield SubDistrictLoading();
    if (event is FetchSubDistrict) {
      List<Subdistrict> data = await rajaOngkirRepository.fetchSubdistrict(event.cityId);
      allSubdistrict = data;
      print(data);
      if (data != null) {
        yield SubDistrictReady(subdistrict: allSubdistrict,selectedSubdistrict:data[0] );
      } else {
        yield SubDistrictError("error response from api");
      }
    }
    if(event is SelectSubDistrict){
      if(event.selectedSubdistrict == null){
        yield SubDistrictEmpty();
      }else {
        yield SubDistrictReady(subdistrict: allSubdistrict, selectedSubdistrict: event.selectedSubdistrict);
      }
    }

  }
}
