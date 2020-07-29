import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/order_box.dart';

abstract class OrderBoxState extends Equatable{
  const OrderBoxState();
}

class OrderBoxDefault extends OrderBoxState{
  final OrderBox orderBox = OrderBox(stateButton: OrderBox.AMBIL_SENDIRI, location: "Pilih kedai kami");
  @override
  List<Object> get props => [];
}

class OrderBoxUpdated extends OrderBoxState{
  final OrderBox orderBox;
  OrderBoxUpdated({this.orderBox});

  @override
  List<Object> get props => [];
}