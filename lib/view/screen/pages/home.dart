import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_bloc.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_event.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/utils/transaction_status.dart';
import 'package:filkop_mobile_apps/view/component/order_box.dart';
import 'package:filkop_mobile_apps/view/component/transaction_card.dart';
import 'package:filkop_mobile_apps/view/screen/detail_transaction.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:filkop_mobile_apps/view/screen/vouchers/main_voucher_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetTransactionsResponse _getTransactionsResponse;
  Future<List<Transaction>> _allTransactions;
  bool _running = false;
  void _refreshTransaction() async {
    List<Transaction> _allTransactionLocal = [];
    if(_running == false){
      print("Stop");
      return;
    }
    print("running");

    _getTransactionsResponse = await ApiService().getAllTransactions();
   _allTransactionLocal.addAll(_getTransactionsResponse.data.data);
    setState(() {
      _allTransactions = Future.value(_allTransactionLocal);
    });
    await Future.delayed(Duration(seconds: 5));
    _refreshTransaction();
  }

  @override
  void initState() {
    _running = true;
    _refreshTransaction();
    super.initState();
  }

  @override
  void dispose() {
    _running = false;
    super.dispose();
  }

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
                        child: Image.asset('images/logo-font.png')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
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
                            padding: EdgeInsets.all(0).copyWith(left:3).copyWith(right: 10),
                            onPressed: () {
                              Navigator.pushNamed(context, MainVoucherScreen.tag);
                            },
                            color: Style.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child:Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Image.asset("images/coupon.png"),
                                        )
                                      ),
                                    )),
                                Text(
                                  "My Coupon",
                                  style:
                                      TextStyle(color: Style.primaryTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<OrderBoxBloc, OrderBoxState>(
                      builder: (context, state) {
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
                            context.bloc<OrderBoxBloc>().add(
                                OrderBoxUpdateStateButton(
                                    stateButton: OrderBoxModel.DIKIRIM));
                          },
                          onPressedAmbilSendiri: () {
                            context.bloc<OrderBoxBloc>().add(
                                OrderBoxUpdateStateButton(
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
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Transaction>>(
                      future: _allTransactions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Transaction> _resultData = snapshot.data;
                          if(_resultData != null){
                          if (_resultData.length > 0) {
                            List<Transaction> _currentTransactions = _resultData
                                
                                .where((element) =>
                            element.trans.status != TransactionStatus.cCANCELLED)
                                .toList();
                            List<Widget> _allTransactions =
                            List<TransactionCard>.from(
                                _currentTransactions.map((e) =>
                                    TransactionCard(transaction: e, onTap: () {
                                      context.bloc<TransactionBloc>().add(
                                          SelectTransaction(e));
                                      Navigator.pushNamed(
                                          context, DetailTransaction.tag);
                                    },)));
                            return Column(
                              children: [
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Transaksi Kamu:")),
                                      SizedBox(height: 10),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: _allTransactions,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }
                          } else {
                            return Container();
                          }
                        }
                        return Container();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _gotoPickOurStoresScreen(BuildContext context) {
    Navigator.pushNamed(context, PickOurStoresScreen.tag);
  }
}
