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
import 'package:filkop_mobile_apps/model/detail_aparel_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/add_note_button.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/component/detail_screen_loading.dart';
import 'package:filkop_mobile_apps/view/component/detail_thumbnail.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/component/variant_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supercharged/supercharged.dart';

class DetailApparelScreen extends StatefulWidget {
  static final String tag = '/detail-apparel-page';

  @override
  _DetailApparelScreenState createState() => _DetailApparelScreenState();
}

class _DetailApparelScreenState extends State<DetailApparelScreen> {
  bool noteAdded = false;
  int _total = 0;
  TextEditingController _nominalTextController;
  Future<DetailApparelResponse> detailApparelResponse;
  DetailApparel _detailApparel;
  List<CartItem> _allCartItem;
  String variantSelected;
  List<bool> selectedVariant = [false, false, false, false, false];
  int _stockTotal = 0;
  String cartId;


  @override
  void initState() {
    var state = context.bloc<CartApparelBloc>().state;
    if(state is CartUpdated){
      _allCartItem = state.cartModel.allProductItems;

    }
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
        cartId = state.orderBox.cartIdApparel;
        if (detailApparelResponse == null) {
          detailApparelResponse = ApiService().getDetailApparel(apparel.id);


        }

        return Scaffold(
          appBar: CustomAppBar(
            titleText: apparel.name,
          ),
          body: FutureBuilder<DetailApparelResponse>(
              future: detailApparelResponse,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(width:MediaQuery.of(context).size.width, height:MediaQuery.of(context).size.height,child: DetailScreenLoading());
                }

                DetailApparelResponse apparelDetail = snapshot.data;
                Stock stocks = apparelDetail.data.stock;
                print("PRINT STOCK IS ${stocks.stock}");
                stocks.updateDepensOnCartItem(_allCartItem, apparelDetail.data.id);
                _detailApparel = apparelDetail.data;
                if(_detailApparel.showSize == "0"){
                  variantSelected = "stock";
                  _stockTotal = stocks.stock.toInt();
                  print("STOCK TOTAL IS $_stockTotal");
                }



                List<Widget> stockWidget = [
                  VariantWidget(
                    stock: stocks,
                    variant: "s",
                    selected: selectedVariant[0],
                    onTap: () {
                      if (stocks.s == "0") return;
                      setState(() {
                        variantSelected = "s";
                        _stockTotal = stocks.s.toInt();
                        selectedVariant = [true, false, false, false, false];
                      });
                    },
                  ),
                  VariantWidget(
                    stock: stocks,
                    variant: "m",
                    selected: selectedVariant[1],
                    onTap: () {
                      if (stocks.m == "0") return;
                      setState(() {
                        variantSelected = "m";
                        _stockTotal = stocks.m.toInt();
                        selectedVariant = [false, true, false, false, false];
                      });
                    },
                  ),
                  VariantWidget(
                    stock: stocks,
                    variant: "l",
                    selected: selectedVariant[2],
                    onTap: () {
                      if (stocks.l == "0") return;
                      setState(() {
                        variantSelected = "l";
                        _stockTotal = stocks.l.toInt();
                        selectedVariant = [false, false, true, false, false];
                      });
                    },
                  ),
                  VariantWidget(
                    stock: stocks,
                    variant: "xl",
                    selected: selectedVariant[3],
                    onTap: () {
                      if (stocks.xl == "0") return;
                      setState(() {
                        variantSelected = "xl";
                        _stockTotal = stocks.xl.toInt();
                        selectedVariant = [false, false, false, true, false];
                      });
                    },
                  ),
                  VariantWidget(
                    stock: stocks,
                    variant: "xxl",
                    selected: selectedVariant[4],
                    onTap: () {
                      if (stocks.xxl == "0") return;
                      setState(() {
                        variantSelected = "xxl";
                        _stockTotal = stocks.xxl.toInt();
                        selectedVariant = [false, false, false, false, true];
                      });
                    },
                  )
                ];

                return Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        DetailThumbnail(
                          image: "${_detailApparel.image[0].linkImage}${_detailApparel.image[0].name}",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            apparel.name.toUpperCase(),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "$priceFormatted",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ),
                            Spacer(),
                            (snapshot.data.data.showSize == "1")?Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: stockWidget,
                                ),
                                SizedBox(height: 10,),
                                Text("Stock: ${_getTotalStock(variantSelected,stocks)}", style: TextStyle(
                                  fontSize: 10,
                                ),)
                              ],
                            ):Text("Stock: ${_getTotalStock(variantSelected,stocks)}", style: TextStyle(
                              fontSize: 10,
                            ),),
                          ],
                        ),
                        Divider(),
                        Html(data: snapshot.data.data.description),
                        Divider(),
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
                                if (cartState is CartInitState) {
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

                                if (cartState is CartUpdateError) {
//                                  Fluttertoast.showToast(msg: "Terjadi kesalahan Server, mohon ulangi lagi");

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
                );
              }),
        );
      }
      return Text("Impossible trough here");
    });
  }

  String _getTotalStock(String variant, Stock stock) {
    print("VARIANT?$variant");
    switch (variant) {
      case "s":
        return stock.s;
        break;
      case "m":
        return stock.m;
        break;
      case "l":
        return stock.l;
        break;
      case "xl":
        return stock.xl;
        break;
      case "xxl":
        return stock.xxl;
        break;
      case "stock":
        print("SHOULD RETURN ${stock.stock}");
        return stock.stock;
        break;
    }
    return "0";
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
      context.bloc<CartApparelBloc>().add(UpdateApparelCart(product: apparel, total: _total, store: location, size: variantSelected, cartId: cartId));
    } else {
      context.bloc<CartApparelBloc>().add(DeleteApparelItemFromCart(cartId: cartId, store: location));
    }
  }

  _setTotal(int total, BuildContext context) {
    _total += total;
    if(_total> _stockTotal){
      Fluttertoast.showToast(msg: "Tidak boleh melebihi stock barang ");
      _total = _stockTotal;
    }
    if (_total < 0) {
      _total = 0;
      _nominalTextController.text = _total.toString();
    }

    context.bloc<OrderBoxBloc>().add(OrderBoxSetTotalSelectedApparel(total: _total));
  }
}
