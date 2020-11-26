
import 'package:filkop_mobile_apps/bloc/apparel/apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/apparel/apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:filkop_mobile_apps/view/component/add_note_button.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/component/detail_thumbnail.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailApparelScreen extends StatefulWidget {
  static final String tag = '/detail-apparel-page';

  @override
  _DetailApparelScreenState createState() => _DetailApparelScreenState();
}

class _DetailApparelScreenState extends State<DetailApparelScreen> {
  bool noteAdded = false;
  int _total = 0;
  TextEditingController _nominalTextController;

  @override
  void initState() {
    super.initState();
    _nominalTextController = TextEditingController(text: "0");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<OrderBoxBloc, OrderBoxState>(builder: (context, state) {
      if (state is OrderBoxUpdated) {
        Apparel apparel = state.orderBox.selectedApparel;
        String priceFormatted = rupiah(apparel.price.toDouble());
        _total = state.orderBox.selectedApparelTotal;
        return Scaffold(
          appBar: CustomAppBar(
            titleText: apparel.name,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  DetailThumbnail(
                    image: "${apparel.image[0]
                        .linkImage}${apparel.image[0].name}",
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      apparel.name.toUpperCase(),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "$priceFormatted",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      apparel.name.toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Visibility(
                    visible: !noteAdded,
                    child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: AddNoteButton(onTap: () {
                          setState(() {
                            noteAdded = true;
                          });
                        })),
                  ),
                  Visibility(
                    visible: noteAdded,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextField(
                        autofocus: true,
                        decoration: CustomMultiTextInputDecoration.create(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: size.width * 0.4,
                          height: 50,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _setTotal(-1, context);
                                },
                                child: Container(
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Center(child: Text("-")),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        "$_total",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  _setTotal(1, context);
                                },
                                child: Container(
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Center(child: Text("+")),
                                    )),
                              )
                            ],
                          ),
                        ),
                        BlocBuilder<CartApparelBloc, CartApparelState>(builder: (context, cartState) {
                          if(cartState is CartInitState){
                            context.bloc<CartApparelBloc>().add(FetchCart());
                          }
                          if (cartState is CartUpdated) {
                            if (_total > 0) {
                              return InkWell(
                                onTap: () {
                                  CartItem cartItem = cartState.cartModel.getCartItemByApparel(apparel);
                                  _updateCart(context, apparel, state.orderBox.location, cartItem: cartItem);
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  decoration: BoxDecoration(color: Colors.black),
                                ),
                              );
                            } else if (state.orderBox.initialSelectedApparelTotal != 0) {
                              return InkWell(
                                onTap: () {
                                  CartItem cartItem = cartState.cartModel.getCartItemByApparel(apparel);
                                  _updateCart(context, apparel, state.orderBox.location, cartItem: cartItem);
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                        "Delete From Cart",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  decoration: BoxDecoration(color: Colors.red.shade800),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }

                          if (cartState is CartEmptyState) {
                            return Visibility(
                              visible: (_total > 0) ? true : false,
                              child: InkWell(
                                onTap: () {
                                  _updateCart(context, apparel, state.orderBox.location);
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  decoration: BoxDecoration(color: Colors.black),
                                ),
                              ),
                            );
                          }

                          if(cartState is CartUpdateError){
                            Fluttertoast.showToast(msg: "Terjadi kesalahan Server, mohon ulangi lagi");

                            return Visibility(
                              visible: (_total > 0) ? true : false,
                              child: InkWell(
                                onTap: () {
                                  _updateCart(context, apparel, state.orderBox.location);
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  decoration: BoxDecoration(color: Colors.black),
                                ),
                              ),
                            );
                          }

                          print(cartState);
                          return Container(
                            width: size.width * 0.4,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  BlocListener<CartApparelBloc, CartApparelState>(
                    listener: (context, state) {
                      if (state is CartUpdated) {
                        context.bloc<ApparelBloc>().add(RefreshApparel());
                        Navigator.of(context).pop();
                      }
                      // do stuff here based on BlocA's state
                    },
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        );
      }
      return Text("Impossible trough here");
    });
  }

  @override
  void deactivate() {
    context.bloc<OrderBoxBloc>().add(OrderBoxUnselectApparel());
    super.deactivate();
  }

  @override
  dispose() {
    _nominalTextController.dispose();
    super.dispose();
  }

  _updateCart(BuildContext context, Apparel apparel, String location, {CartItem cartItem}) {
    print("total is $_total");
    if (_total > 0) {
      context.bloc<CartApparelBloc>().add(UpdateApparelCart(product: apparel, total: _total, store: location));
    } else {
      context.bloc<CartApparelBloc>().add(DeleteApparelItemFromCart(cartId: cartItem.cartId, store: location));
    }
  }

  _setTotal(int total, BuildContext context) {
    _total += total;
    if (_total < 0) {
      _total = 0;
      _nominalTextController.text = _total.toString();
    }

    context.bloc<OrderBoxBloc>().add(OrderBoxSetTotalSelectedApparel(total: _total));
  }
}
