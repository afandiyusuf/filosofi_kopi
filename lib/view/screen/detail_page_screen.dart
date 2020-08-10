import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/add_note_button.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/component/detail_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class DetailPageScreen extends StatefulWidget {
  static final String tag = '/detail-page';

  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
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
        Product product = state.orderBox.selectedProduct;
        FlutterMoneyFormatter fmf =
            FlutterMoneyFormatter(amount: double.parse(product.price));
        String priceFormatted = fmf
            .copyWith(symbol: 'Rp.', symbolAndNumberSeparator: ' ')
            .output
            .symbolOnLeft;
        _total = state.orderBox.selectedTotal;
        print(_total);
        return Scaffold(
          appBar: CustomAppBar(
            titleText: product.name,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  DetailThumbnail(
                    image: product.image,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      product.name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "$priceFormatted",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      product.name.toUpperCase(),
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
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _setTotal(-1, context);
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Center(child: Text("-"))),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      "$_total",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  _setTotal(1, context);
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Center(child: Text("+"))),
                              )
                            ],
                          ),
                        ),
                        BlocBuilder<CartBloc, CartState>(
                            builder: (context, cartState) {
                          if (cartState is CartUpdating) {
                            return Container(
                              width: size.width * 0.4,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return InkWell(
                            onTap: () {
                              _updateCart(context, product, state.orderBox.location);
                            },
                            child: Visibility(
                              visible: _total > 0 ? true : false,
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
                        }),
                      ],
                    ),
                  ),

                  BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      if(state is CartUpdated){
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
  dispose() {
    _nominalTextController.dispose();
    super.dispose();
  }
  _updateCart(BuildContext context,Product product,String location) {
    print("total is $_total");
    context.bloc<CartBloc>().add(UpdateCart(
        product: product,
        total: _total,
        store: location));
  }
  _setTotal(int total, BuildContext context) {
    _total += total;
    if (_total < 0) {
      _total = 0;
      _nominalTextController.text = _total.toString();
    }

    context
        .bloc<OrderBoxBloc>()
        .add(OrderBoxSetTotalSelectedProduct(total: _total));
  }
}
