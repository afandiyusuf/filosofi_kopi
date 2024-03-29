import 'package:filkop_mobile_apps/bloc/gosend/gosend_event.dart';
import 'package:filkop_mobile_apps/bloc/gosend/gosend_state.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GosendBloc extends Bloc<GosendEvent,GosendState>{
  final CartRepository cartRepository;
  GosendBloc({this.cartRepository}) : super(GosendInitState());
  Gosend selectedGosend;
  List<Gosend> datas = [];

  @override
  Stream<GosendState> mapEventToState(GosendEvent event) async* {
    yield GosendUpdating();
    if(event is FetchGosend){
      print("GOSEND FETCH");
      datas = await cartRepository.getGosendData(event.store, event.long, event.lat);
      if(datas != null) {
        if (datas.length == 0) {
          yield GosendError('data null');
        } else {
          selectedGosend = null;
          yield GosendUpdated(datas: datas, selectedGosend: selectedGosend);
        }
      }else{
        yield GosendError('data null');
      }
    }
    if(event is UnpickGosend){
      selectedGosend = null;
      print("GOSEND UNPICK BRO");
      yield(GosendUpdated(datas: datas, selectedGosend: selectedGosend));
    }

    if(event is PickGosend){
      if(datas != null) {
        if (datas.length == 0) {
          yield GosendError("data null");
        } else {
          if (event.type == "Same Day") {
            selectedGosend =
                datas.firstWhere((element) => element.shipmentMethod ==
                    "Same Day");
          } else {
            selectedGosend =
                datas.firstWhere((element) => element.shipmentMethod ==
                    "Instant");
          }

          print("GOSEND PICKED BRO");
          yield GosendPicked(datas: datas, selectedGosend: selectedGosend);
        }
      }else{
        yield GosendError('data null');
      }

    }
  }

}