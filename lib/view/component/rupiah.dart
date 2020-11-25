import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';

String rupiah(double total) {
  int round = total.round();
  return toCurrencyString("$round",
      mantissaLength: 0,
      thousandSeparator: ThousandSeparator.Period,
      leadingSymbol: "Rp ",
      shorteningPolicy: ShorteningPolicy.NoShortening, );
}
