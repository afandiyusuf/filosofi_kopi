import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String Rupiah(double total){
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: total);
  return fmf
      .copyWith(
      symbol: 'Rp.',
      symbolAndNumberSeparator: ' ')
      .output
      .symbolOnLeft;
}
