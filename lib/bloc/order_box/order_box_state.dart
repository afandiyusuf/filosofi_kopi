import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';

abstract class OrderBoxState extends Equatable{
  const OrderBoxState();
}

class OrderBoxDefault extends OrderBoxState{
  final OrderBoxModel orderBox = OrderBoxModel(stateButton: OrderBoxModel.AMBIL_SENDIRI, location: "Pilih kedai kami");
  @override
  List<Object> get props => [];
}

class OrderBoxUpdated extends OrderBoxState{
  final OrderBoxModel orderBox;
  OrderBoxUpdated({this.orderBox});

  @override
  List<Object> get props => [];
}

class OrderBoxUpdating extends OrderBoxState{
  OrderBoxUpdating();

  @override
  List<Object> get props => [];
}