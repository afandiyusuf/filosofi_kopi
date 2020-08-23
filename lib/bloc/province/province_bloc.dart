import 'package:filkop_mobile_apps/bloc/province/province_event.dart';
import 'package:filkop_mobile_apps/bloc/province/province_state.dart';
import 'package:filkop_mobile_apps/model/province_model.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState>{
  final RajaOngkirRepository rajaOngkirRepository;
  ProvinceBloc({this.rajaOngkirRepository}) : super(ProvinceInit());

  @override
  Stream<ProvinceState> mapEventToState(ProvinceEvent event) async* {
    if(event is FetchProvince){
      List<Province> data = await rajaOngkirRepository.fetchProvince();
      if(data != null){
        print(data);
        yield ProvinceReady(data);
      }else{
        yield ProvinceError("error response from api");
      }
    }
  }

}