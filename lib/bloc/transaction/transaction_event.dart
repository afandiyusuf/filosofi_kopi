import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/get_transaction_result.dart';

class TransactionEvent extends Equatable{
  List<Object> get props => [];
}


class SelectTransaction extends TransactionEvent{
  final Transaction transaction;
  SelectTransaction(this.transaction);
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
  final String bankChoice;
  ChangePayment({this.bankChoice});
}