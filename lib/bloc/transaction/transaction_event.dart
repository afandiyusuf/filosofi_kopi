import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:flutter/cupertino.dart';

class TransactionEvent extends Equatable{
  List<Object> get props => [];
}


class SelectTransaction extends TransactionEvent{
  final Transaction transaction;
  SelectTransaction(this.transaction);
}

class SelectTransactionByCode extends TransactionEvent{
  final String transCode;
  final Type type;
  SelectTransactionByCode(this.transCode,this.type);
}

class GetTransactionDetail extends TransactionEvent{
  final Transaction transaction;
  GetTransactionDetail(this.transaction);
}

class SelectPayment extends TransactionEvent{
  final String bankChoice;
  SelectPayment({this.bankChoice});
}

class ChangePayment extends TransactionEvent{
  //need to get context for proceed to snap;
  final BuildContext context;
  final String bankChoice;
  ChangePayment({this.bankChoice,this.context});
}