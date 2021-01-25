import 'package:filkop_mobile_apps/bloc/transaction/transaction_event.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_state.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/utils/banks.dart';
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
      transactionDetailResult = await ApiService().getTransactionDetail(event.transaction.trans.code,(event.transaction.type == Type.APPAREL));
    }

    if(event is SelectPayment){
      print(event.bankChoice);
      var bank = event.bankChoice;
      var transCode = selectedTransaction.trans.code;
      if(bank == "bca" || bank == "mandiri" || bank == "bri"){
        await ApiService().createPaymentXendit(bank, transCode);
      }else if(bank == "cimb" || bank == "bri"){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        print("simulate wait");
        await Future.delayed(Duration(seconds: 2));
      }
      transactionDetailResult =  await ApiService().getTransactionDetail(transCode,(selectedTransaction.type == Type.APPAREL));
      GetTransactionsResponse getTransactionResult;
      getTransactionResult = await ApiService().getAllTransactions();


      selectedTransaction = getTransactionResult.data.data.firstWhere((element) => element.trans.code == selectedTransaction.trans.code);
    }

    if( event is ChangePayment){
      var bank = event.bankChoice;
      var transCode = selectedTransaction.trans.code;
      //delete
      await ApiService().deletePayment(transCode);
      if(bank == Banks.BCA || bank == Banks.MANDIRI || bank == Banks.BRI){
        await ApiService().createPaymentXendit(bank, transCode);
      }else if(bank == Banks.CIMB || bank == Banks.BRI){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        print("simulate wait");
        await Future.delayed(Duration(seconds: 2));
      }
      transactionDetailResult =  await ApiService().getTransactionDetail(transCode,selectedTransaction.type == Type.APPAREL);
      GetTransactionsResponse getTransactionResult = await ApiService().getAllTransactions();

      selectedTransaction = getTransactionResult.data.data.firstWhere((element) => element.trans.code == selectedTransaction.trans.code);
    }

    yield TransactionUpdated(selectedCode: selectedTransaction, transactionDetail: transactionDetailResult);
  }

}