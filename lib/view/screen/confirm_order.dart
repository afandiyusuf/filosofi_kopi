import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_event.dart';
import 'package:filkop_mobile_apps/bloc/adress/address_state.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/gosend/gosend_bloc.dart';
import 'package:filkop_mobile_apps/bloc/gosend/gosend_event.dart';
import 'package:filkop_mobile_apps/bloc/gosend/gosend_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/add_new_address_card.dart';
import 'package:filkop_mobile_apps/view/component/address_card.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/order_box.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/screen/address_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrder extends StatefulWidget {
  static const tag = '/confirm-order';

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool isSwitched = false;
  double currentLong;
  double currentLat;
  UserAddress currentUserAddress;
  CartModel currentCartModel;
  Gosend currentGosend;
  OrderBoxModel currentOrderBox;

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
                        currentOrderBox = state.orderBox;
                        return OrderBox(
                          onPressed: () {},
                          location: state.orderBox.location,
                          stateButton: state.orderBox.stateButton,
                          onPressedAmbilSendiri: () {
                            context.bloc<OrderBoxBloc>().add(
                                OrderBoxUpdateStateButton(
                                    stateButton: OrderBoxModel.AMBIL_SENDIRI));
                            context.bloc<GosendBloc>().add(UnpickGosend());
                          },
                          onPressedDikirim: () {
                            context.bloc<OrderBoxBloc>().add(
                                OrderBoxUpdateStateButton(
                                    stateButton: OrderBoxModel.DIKIRIM));
                            context.bloc<GosendBloc>().add(UnpickGosend());
                          },
                        );
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
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: BlocBuilder<OrderBoxBloc, OrderBoxState>(
                        builder: (context, state) {
                      if (state is OrderBoxUpdated) {
                        if (state.orderBox.stateButton ==
                            OrderBoxModel.DIKIRIM) {
                          return Column(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Alamat Pengiriman",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              Divider(
                                height: 30,
                              ),
                              BlocBuilder<AddressBloc, AddressState>(
                                  builder: (context, addressState) {
                                if (addressState is AddressInit) {
                                  context
                                      .bloc<AddressBloc>()
                                      .add(FetchAddress());
                                }
                                if (addressState is AddressUpdated) {
                                  UserAddress userAddress =
                                      addressState.addressModel.allAddress[0];
                                  try {
                                    currentUserAddress = addressState.addressModel.allAddress.firstWhere((element) => element.selected == 1);
                                  }catch(_){
                                    currentUserAddress = addressState.addressModel.allAddress[0];
                                  }

                                  userAddress = currentUserAddress;
                                  try {
                                    currentLat = double.parse(userAddress.latitude);
                                  }catch(_){
                                    currentLat = 0;
                                  }
                                  try{
                                    currentLong = double.parse(userAddress.longitude);
                                  }catch(_){
                                    currentLong = 0;
                                  }
                                  context.bloc<GosendBloc>().add(FetchGosend(
                                      store: state.orderBox.location,
                                      long: currentLong,
                                      lat: currentLat));
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
                                if (addressState is AddressEmpty) {
                                  return AddNewAddressCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AddressPage.tag);
                                    },
                                  );
                                }
                                print(addressState);
                                return Container();
                              }),
                              BlocBuilder<GosendBloc, GosendState>(
                                  builder: (context, gosendState) {
                                if (gosendState is GosendUpdated) {
                                  currentGosend = gosendState.selectedGosend;

                                  return InkWell(
                                    onTap: () {
                                      _showBottomSheet(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Pilih metode pengiriman"),
                                              Icon(Icons.arrow_forward_ios),
                                            ],
                                          ),
                                        )),
                                  );
                                }
                                if (gosendState is GosendPicked) {
                                  currentGosend = gosendState.selectedGosend;
                                  return InkWell(
                                    onTap: () {
                                      _showBottomSheet(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  title: Text(
                                                    "Gosend ${gosendState.selectedGosend.shipmentMethod} - ${gosendState.selectedGosend.shipmentMethodDescription}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                      "Gosend ${gosendState.selectedGosend.distance} Km -  ${rupiah(double.parse(gosendState.selectedGosend.price.toString()))}"),
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          ),
                                        )),
                                  );
                                }
                                if (gosendState is GosendError) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Text(
                                              "Alamat tidak mendukung pengiriman, silakan pilih/ganti alamat yang lebih dekat")));
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              })
                            ],
                          );
                        } else {
                          return Container(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Pesanan untuk dibawa pulang?"),
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
                      } else {
                        return Container();
                      }
                    }),
                  ),

                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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
                      currentCartModel = cartModel;
                      cartModel.calculateTotalWithDelivery();
                      List<ListTileOrder> listOrder =
                          List<ListTileOrder>.from(cartModel.allItems.map((e) {
                        return ListTileOrder(
                          name: e.name,
                          total: e.total,
                          price: rupiah(double.parse(e.menuPrice)),
                          image: e.photo,
                          onTap: () {
                            _goToDetail(e.convertToProduct(), context);
                          },
                          onDeleteTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            String location = pref.getString('location');
                            _showAlertDelete(
                                context, e.name, e.cartId, location);
                          },
                        );
                      }));
                      return Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "Pesanan kamu",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Divider(
                            height: 20,
                          ),
                          Column(
                            children: listOrder,
                          ),
                          Divider(
                            height: 20,
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text("Subtotal:"),
                                  Text(
                                    "${rupiah(double.parse(cartModel.subtotal.toString()))}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ),
                          Divider(
                            height: 20,
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text("Total:"),
                                  Text(
                                    "${rupiah(double.parse(cartModel.total.toString()))}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ),
                          Divider(
                            height: 20,
                          ),
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
            BlocBuilder<OrderBoxBloc, OrderBoxState>(
                builder: (context, orderBoxState) {
              if (orderBoxState is OrderBoxUpdated) {
                return BlocBuilder<GosendBloc, GosendState>(
                    builder: (context, gosendState) {
                  if (gosendState is GosendPicked ||
                      orderBoxState.orderBox.stateButton ==
                          OrderBoxModel.AMBIL_SENDIRI) {
                    return PrimaryButton(
                        onPressed: () {
                          confirmTransaction(context);
                        },
                        label: "Pesan Sekarang",
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(bottom: 10, top: 10));
                  }
                  return Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text("Silakan pilih metode pengiriman"));
                });
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            }),

            BlocListener<CartBloc,CartState>(
              listener: (context, stateCart){
                if(stateCart is CartEmptyState){
                  Navigator.pop(context);
                }
                if(stateCart is AddTransactionSuccess){
                  Fluttertoast.showToast(
                      msg: "Add Transaction Success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  context.bloc<CartBloc>().add(FetchCart(location: currentOrderBox.location));
                }else if(stateCart is AddTransactionError){
                  _showAlertValidation(stateCart.message, context);
                }
              },
              child: Container(),
            ),
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

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 300,
            child: BlocBuilder<GosendBloc, GosendState>(
              builder: (context, state) {
                if (state is GosendUpdated || state is GosendPicked) {
                  List<Gosend> datas = state.props[0];
                  return ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        Widget secondItem;
                        if (state is GosendUpdated) {
                          secondItem = Container(
                            width: 100,
                            child: PrimaryButton(
                              label: "Pilih",
                              onPressed: () {
                                context.bloc<GosendBloc>().add(
                                    PickGosend(datas[index].shipmentMethod));
                                context.bloc<CartBloc>().add(
                                    UpdateDeliveryMethodCart(
                                        deliverySelected: datas[index]));
                                Navigator.pop(context);
                              },
                            ),
                          );
                        }

                        if (state is GosendPicked) {
                          if (state.selectedGosend.shipmentMethod ==
                              datas[index].shipmentMethod) {
                            secondItem = Container(
                                width: 100,
                                child: Center(child: Icon(Icons.check)));
                          } else {
                            secondItem = Container(
                              width: 100,
                              child: PrimaryButton(
                                  label: "Pilih",
                                  onPressed: () {
                                    context.bloc<GosendBloc>().add(PickGosend(
                                        datas[index].shipmentMethod));
                                    context.bloc<CartBloc>().add(
                                        UpdateDeliveryMethodCart(
                                            deliverySelected: datas[index]));
                                  }),
                            );
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Gosend ${datas[index].shipmentMethod} - ${datas[index].shipmentMethodDescription}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "Gosend ${datas[index].distance} Km -  ${rupiah(double.parse(datas[index].price.toString()))}"),
                                ),
                              ),
                              secondItem
                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              },
            ),
          );
        });
  }

  void confirmTransaction(BuildContext context) {
    if (currentUserAddress == null) {
      Fluttertoast.showToast(
          msg: "Pilih alamat pengiriman terlebih dahulu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    if(currentGosend == null){
      Fluttertoast.showToast(
          msg: "Pilih metode pengiriman terlebih dahulu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

//    context.bloc<CartBloc>().add(AddTransaction(
//       ));
  }

  _showAlertValidation(String errorMessage, BuildContext context) async {
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
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        secondButton: Container(),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
        ),
        // IF YOU WANT TO ADD ICON
        yourWidget: Container(
          child: Text(errorMessage),
        ));
  }
}
