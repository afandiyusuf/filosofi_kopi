import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent,AddressState>{
  UserAddressModel addressModel;
  AddressBloc({this.addressModel}) : super(AddressInit());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async*{

    yield AddressUpdating();

    if(event is FetchAddress){
      addressModel = new UserAddressModel();
      await addressModel.loadAddress();
    }

    if(event is AddAddress){
      UserAddress address = event.address;
      address.id = addressModel.getId().toString();
      addressModel.addAddress(address);
    }

    if(event is RemoveAddress){
      UserAddress address = event.address;
      print('remove here');
      await addressModel.removeAddress(address);
    }
    if(event is SelectAddress){
      await addressModel.select(event.addressId);
    }

    if(event is UpdateAddress){
      UserAddress address = event.address;
      await addressModel.updateAddress(address);
    }

    if(addressModel.allAddress == null || addressModel.allAddress.length == 0){
      yield AddressEmpty();
    }else{
      yield AddressUpdated(addressModel);
    }
  }

}