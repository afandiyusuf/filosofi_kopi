import 'package:filkop_mobile_apps/bloc/city/city_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_state.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final RajaOngkirRepository rajaOngkirRepository;
  List<City> allCities;
  CityBloc({this.rajaOngkirRepository}) : super(CityEmpty());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    yield CityLoading();
    if (event is FetchCity) {
      List<City> data = await rajaOngkirRepository.fetchCity(event.provinceId);
      allCities = data;
      if (data != null) {
        yield CityReady(cities: allCities,selectedCities: data[0].name,realCityName: data[0].realCityName);
      } else {
        yield CityError("error response from api");
      }
    }

    if(event is SelectCity){
      yield CityReady(cities: allCities,selectedCities: event.selectedCity,realCityName: event.realCityName);
    }

  }
}
