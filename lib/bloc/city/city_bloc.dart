import 'package:filkop_mobile_apps/bloc/city/city_event.dart';
import 'package:filkop_mobile_apps/bloc/city/city_state.dart';
import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final RajaOngkirRepository rajaOngkirRepository;
  CityBloc({this.rajaOngkirRepository}) : super(CityEmpty());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    yield CityLoading();
    if (event is FetchCity) {
      List<City> data = await rajaOngkirRepository.fetchCity(event.province_id);
      if (data != null) {
        yield CityReady(cities: data);
      } else {
        yield CityError("error response from api");
      }
    }
  }
}
