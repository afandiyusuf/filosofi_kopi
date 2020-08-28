import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';

class AddressEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchAddress extends AddressEvent{}

class AddAddress extends AddressEvent{
  final UserAddress address;
  AddAddress({this.address});
  @override
  // TODO: implement props
  List<Object> get props => [address];
}
class RemoveAddress extends AddressEvent{
  final UserAddress address;
  RemoveAddress({this.address});
}
class UpdateAddress extends AddressEvent{
  final UserAddress address;
  UpdateAddress({this.address});
}

class SelectAddress extends AddressEvent{
  final int addressId;
  SelectAddress(this.addressId);

}