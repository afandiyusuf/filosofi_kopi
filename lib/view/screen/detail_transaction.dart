import 'package:filkop_mobile_apps/bloc/transaction/transaction_bloc.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_event.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_state.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:filkop_mobile_apps/utils/banks.dart';
import 'package:filkop_mobile_apps/utils/transaction_status.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

class DetailTransaction extends StatefulWidget {
  static const String tag = "/detail-transactions";

  @override
  _DetailTransactionState createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  String selectedBank = "bca";
  List<String> _allBanks = [Banks.BCA,Banks.MANDIRI,Banks.BRI,Banks.CIMB,Banks.BNI,Banks.PERMATA_VA,Banks.GOPAY,Banks.ALFAMART,Banks.CREDIT_CARD];
  Transaction _transaction;

  @override
  void initState() {
    var transactionState = context.bloc<TransactionBloc>().state;
    if (transactionState is TransactionUpdated) {
      _transaction = transactionState.selectedCode;
      context.bloc<TransactionBloc>().add(GetTransactionDetail(_transaction));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> _allDropdownMenu =
        List<DropdownMenuItem<String>>.from(_allBanks.map((e) => DropdownMenuItem<String>(
              child: Container(
                  child: Row(
                children: [
                  Container(height: 25, width: 100, child: Image.asset("images/$e.png")),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "${e.toUpperCase()}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )),
              value: e,
            )));
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Detail Transaksi",
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: SafeArea(
              child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, state) {
                if (state is TransactionUpdated) {
                  if (state.transactionDetail != null) {
                    TransactionDetail _detail = state.transactionDetail.data;
                    if (state.transactionDetail != null) {
                      List<Widget> _listOrder = List<Widget>.from(_detail.cart.map((e) => ListTileOrder(
                            name: e.name,
                            price: rupiah(e.price.toDouble()),
                            image: "https://filkopcdn.b-cdn.net/upload/images/product/${e.productImage}",
                            total: e.qty,
                            usingDelete: false,
                          )));
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (state.selectedCode.trans.status == "6" || state.selectedCode.trans.status == "1")
                                    ? Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Segera selesaikan transaksi anda sebelum stok habis.",
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(),
                                              (state.transactionDetail.data.invoice != null)
                                                  ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Transfer pembayaran ke no rekening:", style: TextStyle(
                                                          fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(height: 10,),
                                                        Row(children: [
                                                          Container(
                                                            width:80,
                                                              child: Image.asset("images/"+state.transactionDetail.data.invoice.paymentChannel.toLowerCase()+".png")),
                                                          SizedBox(width: 20,),
                                                          Text("${state.transactionDetail.data.invoice.paymentCode}", style: TextStyle(
                                                            fontWeight: FontWeight.bold
                                                          ),)
                                                        ],),
                                                        SizedBox(height: 20,),
                                                        Text("Jumlah yang harus dibayar:"),
                                                        SizedBox(height: 10,),
                                                        Text("${rupiah(state.transactionDetail.data.invoice.total.toDouble())}", style: TextStyle(
                                                          fontSize: 25,fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(height: 30,),
                                                      ],
                                                    )
                                                  : Container(),
                                              Text(
                                                (state.selectedCode.trans.status == "6")
                                                    ? "Pilih metode pembayaran:"
                                                    : "Ganti metode pembayaran",
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                  items: _allDropdownMenu,
                                                  value: selectedBank,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedBank = value;
                                                    });
                                                  },
                                                )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              BlocBuilder<TransactionBloc, TransactionState>(
                                                  builder: (context, buttonState) {
                                                if (buttonState is TransactionUpdated) {
                                                  if (buttonState.selectedCode.trans.status == "6") {
                                                    return Container(
                                                      width: double.infinity,
                                                      child: PrimaryButton(
                                                        label: "Pilih Metode Pembayaran",
                                                        onPressed: () {
                                                          context
                                                              .bloc<TransactionBloc>()
                                                              .add(SelectPayment(bankChoice: selectedBank));
                                                        },
                                                      ),
                                                    );
                                                  } else if (buttonState.selectedCode.trans.status == "1") {
                                                    return Container(
                                                      width: double.infinity,
                                                      child: PrimaryButton(
                                                        label: "Ganti Metode Pembayaran",
                                                        onPressed: () {
                                                          context
                                                              .bloc<TransactionBloc>()
                                                              .add(ChangePayment(bankChoice: selectedBank));
                                                        },
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: double.infinity,
                                                      child: PrimaryButton(
                                                        label: "Pilih Metode ${buttonState.selectedCode.trans.status}",
                                                        onPressed: () {},
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  return Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }
                                              })
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Kode Order:"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${state.selectedCode.trans.code}",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: _listOrder,
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Biaya Antar:"),
                                              Text(
                                                rupiah(_detail.transaction[0].shippingCost.toDouble()),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Pembayaran:"),
                                              Text(
                                                rupiah(_detail.transaction[0].total.toDouble()),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Nama:",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                Text("${_detail.transaction[0].fullname}"),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Order Status:",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                Text("${TransactionStatus.getStringStatus(state.selectedCode.trans.status)}"),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Tanggal Pemesanan:",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                Text("${state.selectedCode.trans.createdDate}"),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Alamat Pengiriman:",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                    "${_detail.transaction[0].address} - ${_detail.transaction[0].city} - ${_detail.transaction[0].province}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<TransactionBloc, TransactionState>(builder: (context, buttonState) {
                  if (buttonState is TransactionUpdated) {
                    print(buttonState.selectedCode.trans.status);
                    String _status = buttonState.selectedCode.trans.status;
                    if (_status == TransactionStatus.cDEFAULT) {
                      return Container(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: "Pilih Metode Pembayaran",
                          onPressed: () {
                            context.bloc<TransactionBloc>().add(SelectPayment(bankChoice: selectedBank));
                          },
                        ),
                      );
                    } else if (buttonState.selectedCode.trans.status == TransactionStatus.cWAITING_PAYMENT) {
                      return Container(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: "Ganti Metode Pembayaran",
                          onPressed: () {
                            context.bloc<TransactionBloc>().add(ChangePayment(bankChoice: selectedBank));
                          },
                        ),
                      );
                    } else {
                      return Container(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Silahkan lakukan pembayaran",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )));
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
