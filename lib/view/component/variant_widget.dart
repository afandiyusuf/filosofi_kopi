import 'package:filkop_mobile_apps/model/detail_aparel_response.dart';
import 'package:flutter/material.dart';

class VariantWidget extends StatelessWidget {
  final Stock stock;
  final String variant;
  final bool selected;
  final Function onTap;
  const VariantWidget({Key key, this.stock, this.variant, this.selected, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:2.0),
        child: Container(
          decoration: _getBoxDecoration(variant),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 2),
            child: Text("${variant.toUpperCase()}", style: TextStyle(color: (selected)?Colors.white:Colors.black,fontSize: 10),),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration(String variant){
    bool kosong = true;
    switch(variant){
      case "s":
         kosong = stock.s == '0'? true : false;
        break;
      case "m":
        kosong = stock.m == '0'? true : false;
        break;
      case "l":
        kosong = stock.l == '0'? true : false;
        break;
      case "xl":
        kosong = stock.xl == '0'? true : false;
        break;
      case "xxl":
        kosong = stock.xxl == '0'? true : false;
        break;
      default:
        break;
    }

    if(kosong){
      //kosoooong
      return BoxDecoration(
          border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey
      );
    }else{
      if(selected) {
        return BoxDecoration(
          border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black
        );
      }else{
        return BoxDecoration(
          border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        );
      }
      //ada
    }
  }
}
