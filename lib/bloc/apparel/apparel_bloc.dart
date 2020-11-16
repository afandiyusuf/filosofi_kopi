import 'package:filkop_mobile_apps/bloc/apparel/apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/apparel/apparel_state.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/repository/apparel_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApparelBloc extends Bloc<ApparelEvent, ApparelState>{
  final ApparelRepository repository;
  Apparel selectedApparel;
  ApparelModel _apparelModel;
  ApparelBloc({@required this.repository}) : assert(repository != null), super(ApparelEmpty());

  @override
  Stream<ApparelState> mapEventToState(ApparelEvent event) async* {
    yield ApparelDataLoading();

    if(event is FetchApparel){
      try{
        _apparelModel = await repository.getProductModelByStore(event.store);
        print("FETCH PRODUCT FROM BLOC $_apparelModel");
        yield ApparelDataLoaded(apparels: _apparelModel);
      }catch(_){
        print(_.toString());
        yield ApparelDataError();
      }
    }

    if(event is SetApparelByCategory){
      print("SET PRODUCT BY CATEGORY?");
      try{
         _apparelModel.setByCategory(event.categoryName);
         yield ApparelDataLoaded(apparels: _apparelModel);
      }catch(_){
        print(_.toString());
        yield ApparelDataError();
      }
    }

    if(event is RefreshProduct){
      if(_apparelModel == null){
        SharedPreferences pref = await SharedPreferences.getInstance();
        String location = pref.getString('location');
        _apparelModel = await repository.getProductModelByStore(location);
      }
      yield ApparelDataLoaded(apparels: _apparelModel);
    }
  }
  
}