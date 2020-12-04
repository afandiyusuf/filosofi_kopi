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
      transactionDetailResult = await ApiService().getTransactionDetail(event.transaction.code,event.transaction.isApparel);
    }

    if(event is SelectPayment){
      print(event.bankChoice);
      var bank = event.bankChoice;
      var transCode = selectedTransaction.code;
      if(bank == "bca" || bank == "mandiri" || bank == "bri"){
        await ApiService().createPaymentXendit(bank, transCode);
      }else if(bank == "cimb" || bank == "bri"){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        print("simulate wait");
        await Future.delayed(Duration(seconds: 2));
      }
      transactionDetailResult =  await ApiService().getTransactionDetail(transCode,selectedTransaction.isApparel);
      GetTransactionResult getTransactionResult;
      if(selectedTransaction.isApparel == false) {
        getTransactionResult = await ApiService().getTransactionFnb();
      }else{
        getTransactionResult = await ApiService().getTransactionApparel();
      }
      selectedTransaction = getTransactionResult.data.firstWhere((element) => element.code == selectedTransaction.code);
    }

    if( event is ChangePayment){
      var bank = event.bankChoice;
      var transCode = selectedTransaction.code;
      //delete
      await ApiService().deletePayment(transCode);
      if(bank == "bca" || bank == "mandiri" || bank == "bri"){
        await ApiService().createPaymentXendit(bank, transCode);
      }else if(bank == "cimb" || bank == "bri"){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        print("simulate wait");
        await Future.delayed(Duration(seconds: 2));
      }
      transactionDetailResult =  await ApiService().getTransactionDetail(transCode,selectedTransaction.isApparel);
      GetTransactionResult getTransactionResult;
      if(selectedTransaction.isApparel == false) {
         getTransactionResult = await ApiService().getTransactionFnb();
      }else{
        getTransactionResult = await ApiService().getTransactionApparel();
      }
      selectedTransaction = getTransactionResult.data.firstWhere((element) => element.code == selectedTransaction.code);
    }

    yield TransactionUpdated(selectedCode: selectedTransaction, transactionDetail: transactionDetailResult);
  }

}