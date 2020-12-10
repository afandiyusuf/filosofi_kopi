import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:flutter/material.dart';

class DetailVoucherPage extends StatefulWidget {
  static const String tag = "/detail-vouchers";
  @override
  _DetailVoucherPageState createState() => _DetailVoucherPageState();
}

class _DetailVoucherPageState extends State<DetailVoucherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Detail Kupon",usingBack: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(aspectRatio: 2/1,child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("KUPON MERDEKA 75", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),textAlign: TextAlign.start,),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.lock_clock),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Berlaku hingga",
                                            style: TextStyle(fontSize: 11),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "2020-10-30",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.monetization_on),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Point yang dibutuhkan",
                                              style: TextStyle(fontSize: 11),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              "300",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.monetization_on),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Minimum transaksi",
                                      style: TextStyle(fontSize: 11),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Rp 100.000",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Divider(),
                          Text("Syarat & Ketentuan", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),textAlign: TextAlign.start,),
                          SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            height: 200,
                          ),
                          SizedBox(height: 15,),
                          Divider(),
                          Text("Cara Pakai", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),textAlign: TextAlign.start,),
                          SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            height: 200,
                          ),
                          SizedBox(height: 100,)
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,left: 0,right: 0,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        color:Colors.white,
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        top: 20,
                        child: Container(
                          height: 40,
                          child: PrimaryButton(
                            label: "Gunakan",
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
