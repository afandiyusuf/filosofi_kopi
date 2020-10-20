import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_event.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_state.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubDistrictBloc extends Bloc<SubDistrictEvent, SubDistrictState> {
  final RajaOngkirRepository rajaOngkirRepository;
  List<City> allCities;
  SubDistrictBloc({this.rajaOngkirRepository}) : super(SubDistrictEmpty());

  @override
  Stream<SubDistrictState> mapEventToState(SubDistrictEvent event) async* {
    yield SubDistrictLoading();
    if (event is FetchSubDistrict) {
      List<City> data = await rajaOngkirRepository.fetchCity(event.cityId);
      allCities = data;
      if (data != null) {
        yield SubDistrictReady(cities: allCities,selectedCities: data[0].name,realCityName: data[0].realCityName);
      } else {
        yield SubDistrictError("error response from api");
      }
    }
    if(event is SelectSubDistrict){
      yield SubDistrictReady(cities: allCities,selectedCities: event.selectedSubDistrict,realCityName: event.realSubDistrictName);
    }

  }
}
