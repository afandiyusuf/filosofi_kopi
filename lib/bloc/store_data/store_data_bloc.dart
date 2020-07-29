import 'package:filkop_mobile_apps/bloc/store_data//store_data_event.dart';
import 'package:filkop_mobile_apps/bloc/store_data/store_data_state.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:filkop_mobile_apps/repository/store_data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreDataBloc extends Bloc<StoreDataEvent, StoreDataState>{
  final StoreDataRepository repository;

  StoreDataBloc({@required this.repository}) : assert(repository != null), super(StoreDataEmpty());
  
  @override
  Stream<StoreDataState> mapEventToState(StoreDataEvent event) async * {
    if (event is FetchStoreData){
      print("hello there");
      yield StoreDataLoading();
      try{
        final StoreDatas  storeDatas = await repository.fetchStore();
        print("hello there");
        yield StoreDataLoaded(storeDatas:  storeDatas);
      }catch(_){
        yield StoreDataError();
      }
    }
  }
}