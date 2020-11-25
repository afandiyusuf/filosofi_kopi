import 'package:filkop_mobile_apps/bloc/transaction/transaction_event.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_state.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_result.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  Transaction selectedTransaction;
  GetTransactionDetailResult transactionDetailResult;
  TransactionBloc(TransactionState initialState) : super(initialState);

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    yield TransactionUpdating();

    if(event is SelectTransaction){
      selectedTransaction = event.transaction;
    }

    if(event is GetTransactionDetail){
      transactionDetailResult =  await ApiService().getTransactionDetail(event.transaction.code);
    }

    yield TransactionUpdated(selectedCode: selectedTransaction, transactionDetail: transactionDetailResult);
  }

}