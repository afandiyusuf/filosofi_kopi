import 'dart:convert';

import 'package:filkop_mobile_apps/bloc/transaction/transaction_event.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_state.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/utils/banks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
      print("BANK CHOICE IS");
      print(event.bankChoice);
      var bank = event.bankChoice;
      var transCode = selectedTransaction.trans.code;
      if(bank == Banks.BCA || bank == Banks.MANDIRI || bank == Banks.BRI){
        await ApiService().createPaymentXendit(bank, transCode);
      }else if(bank == Banks.CIMB || bank == Banks.BNI){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        String urlMidtrans = getUrlMidtrans(bank,transCode);
        if(await canLaunch(urlMidtrans)){
          await launch(urlMidtrans);
          print("HEREEE");
        }else{
          Fluttertoast.showToast(msg: "Payment not valid");
        }
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
      }else if(bank == Banks.CIMB || bank == Banks.BNI){
        await ApiService().createPaymentIpay(bank, transCode);
      }else {
        String urlMidtrans = getUrlMidtrans(bank,transCode);
        if(await canLaunch(urlMidtrans)){
          await launch(urlMidtrans);
          print("HEREEE");
        }else{
          Fluttertoast.showToast(msg: "Payment not valid");
        }
//        await Future.delayed(Duration(seconds: 2));
      }
      transactionDetailResult =  await ApiService().getTransactionDetail(transCode,selectedTransaction.type == Type.APPAREL);
      GetTransactionsResponse getTransactionResult = await ApiService().getAllTransactions();

      selectedTransaction = getTransactionResult.data.data.firstWhere((element) => element.trans.code == selectedTransaction.trans.code);
    }

    if(event is SelectTransactionByCode){
      yield TransactionUpdating();
      String code = event.transCode;
      Type type = event.type;
      print("CODE IS $code");
      transactionDetailResult = await ApiService().getTransactionDetail(code, type == Type.APPAREL);
      GetTransactionsResponse getTransactionResult = await ApiService().getAllTransactions();
      selectedTransaction = getTransactionResult.data.data.firstWhere((element) => element.trans.code == transactionDetailResult.data.transaction[0].code);
      print("DETAIL RESULT IS");
      print(json.encode(transactionDetailResult));
    }

    yield TransactionUpdated(selectedCode: selectedTransaction, transactionDetail: transactionDetailResult);
  }

}