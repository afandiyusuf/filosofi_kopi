import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBoxBloc extends Bloc<OrderBoxEvent, OrderBoxState>{
  OrderBoxBloc() : super(OrderBoxDefault());
  OrderBoxModel _orderBox = OrderBoxDefault().orderBox;
  Product detailProductSelected;
  Apparel detailApparelSelected;

  OrderBoxModel get orderBox => _orderBox;

  @override
  Stream<OrderBoxState> mapEventToState(OrderBoxEvent event) async* {
    yield OrderBoxUpdating();
    if(event is OrderBoxUpdate){
      print("order update");
      _orderBox = event.orderBox;
    }
    if(event is OrderBoxUpdateStateButton){
      print("order update state");
      _orderBox.stateButton = event.stateButton;
    }
    if(event is OrderBoxUpdateLocation){
      print("order update location");
      _orderBox.location = event.location;
      _orderBox.storeId = event.storeId;
    }

    if(event is OrderBoxSelectProduct){
      print("select product");
      _orderBox.selectedProduct = event.selectedProduct;
      _orderBox.selectedProductTotal = event.total;
      _orderBox.initialSelectedProductTotal = event.total;
    }



    if(event is OrderBoxUnselectProduct){
      print("unselect product");
      _orderBox.selectedProduct = null;
      _orderBox.selectedProductTotal = 0;
      _orderBox.initialSelectedProductTotal = 0;
    }

    if(event is OrderBoxSetTotalSelectedProduct){
      print("set total selected");
      _orderBox.selectedProductTotal = event.total;
    }

    if(event is OrderBoxSelectApparel){
      print("select apparel");
      _orderBox.selectedApparel = event.selectedApparel;
      _orderBox.selectedApparelTotal = event.total;
      _orderBox.initialSelectedApparelTotal = event.total;
    }

    if(event is OrderBoxUnselectProduct){
      print("unselect apparel");
      _orderBox.selectedApparel = null;
      _orderBox.selectedApparelTotal = 0;
      _orderBox.initialSelectedApparelTotal = 0;
    }

    if(event is OrderBoxSetTotalSelectedProduct){
      print("set total selected");
      _orderBox.selectedApparelTotal = event.total;
    }


    yield OrderBoxUpdated(orderBox: _orderBox);
  }

}