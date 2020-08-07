import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBoxBloc extends Bloc<OrderBoxEvent, OrderBoxState>{
  OrderBoxBloc() : super(OrderBoxDefault());
  OrderBoxModel _orderBox = OrderBoxDefault().orderBox;
  Product detailProductSelected;

  OrderBoxModel get orderBox => _orderBox;

  @override
  Stream<OrderBoxState> mapEventToState(OrderBoxEvent event) async* {
    yield OrderBoxUpdating();
    if(event is OrderBoxUpdate){
      _orderBox = event.orderBox;
      yield OrderBoxUpdated(orderBox: _orderBox);
    }
    if(event is OrderBoxUpdateStateButton){
      _orderBox.stateButton = event.stateButton;
      yield OrderBoxUpdated(orderBox: _orderBox);
    }
    if(event is OrderBoxUpdateLocation){
      _orderBox.location = event.location;
      _orderBox.storeId = event.storeId;
      yield OrderBoxUpdated(orderBox: _orderBox);
    }

    if(event is OrderBoxSelectProduct){
      _orderBox.selectedProduct = event.selectedProduct;
      _orderBox.selectedTotal = event.total;
      yield OrderBoxUpdated(orderBox: _orderBox);
    }

    if(event is OrderBoxSetTotalSelectedProduct){
      _orderBox.selectedTotal = event.total;
      yield OrderBoxUpdated(orderBox: _orderBox);
    }

  }

}