import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/order_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBoxBloc extends Bloc<OrderBoxEvent, OrderBoxState>{
  OrderBoxBloc() : super(OrderBoxDefault());
  OrderBox _orderBoxBloc = OrderBoxDefault().orderBox;

  @override
  Stream<OrderBoxState> mapEventToState(OrderBoxEvent event) async* {
    if(event is OrderBoxUpdate){
      print(event.orderBox.location);
      _orderBoxBloc = event.orderBox;
      yield OrderBoxUpdated(orderBox: event.orderBox);
    }

    if(event is OrderBoxUpdateLocation){
      _orderBoxBloc.location = event.location;
      yield OrderBoxUpdated(orderBox: _orderBoxBloc);
    }

  }

}