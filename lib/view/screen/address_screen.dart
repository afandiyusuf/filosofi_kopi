import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/view/component/add_new_address_card.dart';
import 'package:filkop_mobile_apps/view/component/address_card.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/screen/address_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressPage extends StatefulWidget {
  static const String tag = '/tag';

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  Future<String> stateAddress;
  bool a0 = false;
  Permission locationPermission = Permission.location;
  Future<PermissionStatus> status;
  Future<String> setStateAddress(String state) async {
    return state;
  }

  @override
  void initState() {
    status = locationPermission.request();
    stateAddress = setStateAddress('empty');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
      future: status,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data == PermissionStatus.undetermined){
          }else{
            status = locationPermission.request();
            return Center(child: CircularProgressIndicator());
          }
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        return Scaffold(
          appBar: CustomAppBar(
            titleText: 'Manage Address',
          ),
          body: Container(
              child: Column(
                children: [
                  AddNewAddressCard(onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddressPick(userAddress: null,)
                    ));
                  },)
                  ,
                  BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressUpdating) {
                          print("UPDATING");
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AddressInit) {
                          context.bloc<AddressBloc>().add(FetchAddress());
                        }

                        if (state is AddressUpdated) {
                          print("UPDATED");
                          UserAddressModel addressModel = state.addressModel;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.builder(
                                  itemCount: addressModel.allAddress.length,
                                  itemBuilder: (context, index) {
                                    UserAddress userAddress = addressModel
                                        .allAddress[index];
                                    return AddressCard(
                                      userAddress: userAddress, onSelect: () {
                                      context.bloc<AddressBloc>().add(
                                          SelectAddress(userAddress.id));
                                    }, onEdit: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              AddressPick(
                                                userAddress: userAddress,)
                                      ));
                                    }, onDelete: () {
                                      context.bloc<AddressBloc>().add(
                                          RemoveAddress(address: userAddress));
                                    },);
                                  }),
                            ),
                          );
                        }


                        return Container();
                      }),
                ],
              )),
        );
      }
    );
  }
}
