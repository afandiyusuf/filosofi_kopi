import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/screen/vouchers/vouchers_page.dart';
import 'package:flutter/material.dart';

class MainVoucherScreen extends StatefulWidget {
  static const String tag = "/vouchers";
  @override
  _MainVoucherScreenState createState() => _MainVoucherScreenState();
}

class _MainVoucherScreenState extends State<MainVoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Coupon", style: TextStyle(
          color: Colors.black
        ),),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
          shadowColor: Colors.black,
          bottom: TabBar(
            onTap: (int){
              print(int);
            },
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Text("Available Coupon", style: TextStyle(
                  color: Colors.black
              ),),),
              Tab(icon: Text("My Coupon", style: TextStyle(
                  color: Colors.black
              ),),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VouchersPage(),
            Container(),
          ],
        ),
      ),
    );
  }
}
