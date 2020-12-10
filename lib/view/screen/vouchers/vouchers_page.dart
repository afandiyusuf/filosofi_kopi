import 'package:filkop_mobile_apps/view/component/voucher_tumbnail.dart';
import 'package:filkop_mobile_apps/view/screen/vouchers/detail_voucher_page.dart';
import 'package:flutter/material.dart';

class VouchersPage extends StatefulWidget {
  @override
  _VouchersPageState createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
        return VoucherThumbnail(onTap: (){
          _showDetailInfo(context);
        },);
      },),
    );
  }

  _showDetailInfo(BuildContext context){
    Navigator.pushNamed(context, DetailVoucherPage.tag);
//    showBottomSheet(context: context, builder: (context){
//      return Container(width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height);
//    });
  }
}
