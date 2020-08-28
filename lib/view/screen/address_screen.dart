import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/view/component/address_card.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/screen/address_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatefulWidget {
  static const String tag = '/tag';

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  Future<String> stateAddress;

  Future<String> setStateAddress(String state) async {
    return state;
  }

  @override
  void initState() {
    stateAddress = setStateAddress('empty');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Manage Address',
      ),
      body: Container(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddressPick(userAddress: null,)
              ));
            },
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [Icon(Icons.add), Text("Add new address")],
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
            if (state is AddressUpdating) {
              print("UPDATING");
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is AddressInit){
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
                        UserAddress userAddress = addressModel.allAddress[index];
                        return AddressCard(userAddress: userAddress,onSelect: (){
                          context.bloc<AddressBloc>().add(SelectAddress(userAddress.id));
                        },onEdit: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddressPick(userAddress: userAddress,)
                          ));
                        }, onDelete: (){
                          context.bloc<AddressBloc>().add(RemoveAddress(address: userAddress));
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
}
