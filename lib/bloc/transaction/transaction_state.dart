import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';

class TransactionState extends Equatable{
  List<Object> get props => [];
}

class TransactionInit extends TransactionState{}
class TransactionUpdating extends TransactionState{}
class TransactionUpdated extends TransactionState{
  final Transaction selectedCode;
  final GetTransactionDetailResult transactionDetail;
  TransactionUpdated({this.transactionDetail, this.selectedCode});
}