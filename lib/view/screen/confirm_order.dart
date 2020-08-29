import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_state.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/add_new_address_card.dart';
import 'package:filkop_mobile_apps/view/component/address_card.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/order_box.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/screen/address_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrder extends StatefulWidget {
  static const tag = '/confirm-order';

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Confirm Order",
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(12),
                children: <Widget>[
                  /*
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 15),
                      child: Text("Detail Pesanan kamu")),
                  Divider(
                    height: 30,
                  ),
                  */
                  //Button dikirim diambil
                  BlocBuilder<OrderBoxBloc, OrderBoxState>(
                    builder: (context, state) {
                      if (state is OrderBoxUpdated) {
                        return OrderBox(onPressed: (){
                        },location: state.orderBox.location, stateButton: state.orderBox.stateButton, onPressedAmbilSendiri: (){
                          context.bloc<OrderBoxBloc>().add(OrderBoxUpdateStateButton(stateButton: OrderBoxModel.AMBIL_SENDIRI));
                        },onPressedDikirim: (){
                          context.bloc<OrderBoxBloc>().add(OrderBoxUpdateStateButton(stateButton: OrderBoxModel.DIKIRIM));
                        },);

                      }
                      return Container();
                    },
                  ),
                  //end Button dikirim diambil

                  //Estimasi pesanan selesai
                  /*
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.grey.shade200,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "ESTIMASI PESANANMU SELESAI PADA PUKUL",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade500),
                            )),
                        Container(
                          margin: EdgeInsets.only(bottom: 15, top: 10),
                          child: Text(
                            "10 : 20",
                            style: TextStyle(
                                fontSize: 32, color: Colors.grey.shade700),
                          ),
                        )
                      ],
                    ),
                  ),
                  */
                  //end Estimasi pesanan selesai

                  //Alamat Pengiriman
                  Container(
                    margin: EdgeInsets.only(top: 30,bottom: 20),
                    child: BlocBuilder<OrderBoxBloc,OrderBoxState>(
                      builder: (context, state) {
                        if(state is OrderBoxUpdated) {
                          if(state.orderBox.stateButton == OrderBoxModel.DIKIRIM) {
                            return Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Alamat Pengiriman",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    )),
                                Divider(
                                  height: 30,
                                ),

                                BlocBuilder<AddressBloc, AddressState>(
                                    builder: (context, state) {
                                      if (state is AddressInit) {
                                        context.bloc<AddressBloc>().add(
                                            FetchAddress());
                                      }
                                      if (state is AddressUpdated) {
                                        print("UPDATED");
                                        UserAddress userAddress =
                                        state.addressModel.allAddress[0];
                                        return AddressCard(
                                          userAddress: userAddress,
                                          onSelect: () {
                                            Navigator.pushNamed(
                                                context, AddressPage.tag);
                                          },
                                          onEdit: () {},
                                          onDelete: () {},
                                          usingActionButton: false,
                                        );
                                      }
                                      if (state is AddressEmpty) {
                                        return AddNewAddressCard(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, AddressPage.tag);
                                          },
                                        );
                                      }
                                      return Text("NULL");
                                    }),
                              ],
                            );
                          }else{
                            return  Container(
                                color: Colors.grey.shade200,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              "Pesanan untuk dibawa pulang?"),
                                          FlutterSwitch(
                                              width: 80.0,
                                              height: 40.0,
                                              valueFontSize: 11.0,
                                              toggleSize: 20.0,
                                              value: isSwitched,
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              activeText: "Ya",
                                              inactiveText: "Tidak",
                                              onToggle: (val) {
                                                setState(() {
                                                  isSwitched = val;
                                                });
                                              }),
                                        ],
                                      ),
                                    )));
                          }
                        }else{
                          return Container();
                        }
                      }
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                      child: Text("Pesanan kamu", style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),)),
                  Divider(height: 20,),
                  BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                    if (state is CartInitState) {
                      fetchCart(context);
                    }

                    if (state is CartEmptyState) {
                      return Container(
                        child: Center(child: Text("Cart Kosong")),
                      );
                    }

                    if (state is CartUpdated) {
                      CartModel cartModel = state.cartModel;
                      List<ListTileOrder> listOrder =
                          List<ListTileOrder>.from(
                              cartModel.allItems.map((e) {
                        return ListTileOrder(
                          name: e.name,
                          total: e.total,
                          price: e.menuPrice,
                          image: e.photo,
                          onTap: () {
                            _goToDetail(
                                e.convertToProduct(), context);
                          },
                          onDeleteTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            String location =
                            pref.getString('location');
                            _showAlertDelete(context, e.name,
                                e.cartId, location);
                          },
                        );
                      }));
                      return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: listOrder,
                              )
                            ],
                          ));
                    }

                    if (state is CartUpdating) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is CartEmptyState) {
                      return Container();
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ],
              ),
            ),
            Container(
              child: PrimaryButton(
                label: "Pesan Sekarang",
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(bottom: 10),
              ),
            )
          ],
        ),
      ),
    );
  }

  _goToDetail(Product product, BuildContext context) {
    int total = 0;
    if (context.bloc<CartBloc>().state is CartUpdated) {
      CartUpdated state = context.bloc<CartBloc>().state;
      if (state.cartModel != null) {
        //get total menu
        total = state.cartModel.getTotalItemsByIndex(product.id);
      }
    }
    context
        .bloc<OrderBoxBloc>()
        .add(OrderBoxSelectProduct(selectedProduct: product, total: total));
    Navigator.pushNamed(context, DetailPageScreen.tag);
  }

  _showAlertDelete(
      BuildContext context, String name, String cartId, String store) async {
    print("here");
    print("$cartId, $store");
    await animated_dialog_box.showInOutDailog(
        title: Center(child: Text("Warning")),
        // IF YOU WANT TO ADD
        context: context,
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.red,
          child: Text('Ya, Hapus!'),
          onPressed: () {
            context
                .bloc<CartBloc>()
                .add(DeleteItemFromCart(cartId: cartId, store: store));
            Navigator.of(context).pop();
          },
        ),
        secondButton: MaterialButton(
          // OPTIONAL BUTTON
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
        ),
        // IF YOU WANT TO ADD ICON
        yourWidget: Container(
          child: Text(
              'Apa kamu yakin ingin menghapus ($name) dari keranjang belanjaan kamu?'),
        ));
  }

  void fetchCart(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String location = pref.getString('location');
    context.bloc<CartBloc>().add(FetchCart(location: location));
  }
}
