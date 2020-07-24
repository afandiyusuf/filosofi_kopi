import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/order_box.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ConfirmOrder extends StatefulWidget {
  static const tag = '/confirm-order';

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool isSwitched = false;
  ProductModel pm = new ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Confirm Order",
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            OrderBox(
              onPressed: () {},
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5),
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black38, width: 1))),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Pesanan kamu"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: pm.getTotal(),
                          itemBuilder: (BuildContext context, int index) {
                            Product p = pm.getByIndex(index);
                            return ListTileOrder(
                              name: p.name,
                              price: p.price.toString(),
                              total: 2.toString(),
                              image: p.image,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
}
