import 'package:filkop_mobile_apps/bloc/store_selected/store_selected_event.dart';
import 'package:filkop_mobile_apps/bloc/store_selected/store_selected_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreSelectedBloc extends Bloc<StoreSelectedEvent,StoreSelectedState>{
  StoreSelectedBloc() : super(StoreSelectedEmpty());

  @override
  Stream<StoreSelectedState> mapEventToState(StoreSelectedEvent event) async* {

    if(event is UpdateStoreSelected){
      yield StoreSelectedUpdated(store: event.store);
    }
  }

}