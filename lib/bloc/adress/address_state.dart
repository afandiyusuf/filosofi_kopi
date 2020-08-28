import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';

class AddressState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddressInit extends AddressState{}
class AddressEmpty extends AddressState{}
class AddressUpdated extends AddressState{
  final UserAddressModel addressModel;
  AddressUpdated(this.addressModel);
}
class AddressUpdating extends AddressState{}