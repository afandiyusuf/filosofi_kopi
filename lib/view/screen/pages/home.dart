import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/view/component/order_box.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  HomePage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          //TOP SECTION
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    height: 100,
                    child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: Image.asset('images/logo.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Your point",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              "0 pts",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {},
                          color: Style.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                              Text(
                                "Add Point",
                                style: TextStyle(color: Style.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<OrderBoxBloc, OrderBoxState>(builder: (context, state) {
            if (state is OrderBoxUpdating) {
              return CircularProgressIndicator();
            }
            if (state is OrderBoxUpdated) {

              return Container(
                margin: EdgeInsets.only(top: 30),
                child: OrderBox(
                  onPressed: () {
                    _gotoPickOurStoresScreen(context);
                  },
                  location: state.orderBox.location,
                  stateButton: state.orderBox.stateButton,
                  onPressedDikirim: () {
                    context.bloc<OrderBoxBloc>().add(OrderBoxUpdateStateButton(
                        stateButton: OrderBoxModel.DIKIRIM));
                  },
                  onPressedAmbilSendiri: () {
                    context.bloc<OrderBoxBloc>().add(OrderBoxUpdateStateButton(
                        stateButton: OrderBoxModel.AMBIL_SENDIRI));
                  },
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: 30),
                child: OrderBox(
                  location: "Pick your store",
                  onPressed: () {
                    _gotoPickOurStoresScreen(context);
                  },
                  onPressedAmbilSendiri: () {
                    _gotoPickOurStoresScreen(context);
                  },
                  onPressedDikirim: () {
                    _gotoPickOurStoresScreen(context);
                  },
                  stateButton: 0,
                ),
              );
            }
          })
        ],
      ),
    );
  }

  _gotoPickOurStoresScreen(BuildContext context) {
    Navigator.pushNamed(context, PickOurStoresScreen.tag);
  }
}
