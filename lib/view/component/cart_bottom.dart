import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartBottom extends StatelessWidget {
  final Function onPressed;
  final String total;
  final String price;
  final double marginBottom;
  CartBottom({this.onPressed, this.total, this.price, this.marginBottom = 55});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Estimasi Harga | $total barang", style: TextStyle(
                  fontSize: 12,
                ),),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("$price", style: TextStyle(
                      fontSize: 25
                  ),),
                )
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: PrimaryButton(label: "Pesan",
                margin: EdgeInsets.only(right: 15),
                onPressed: (){
                  onPressed();
                },))
        ],
      ),
    );
  }
}
