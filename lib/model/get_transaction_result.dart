


// To parse this JSON data, do
//
//     final getTransactionResult = getTransactionResultFromJson(jsonString);

import 'dart:convert';

GetTransactionResult getTransactionResultFromJson(String str) => GetTransactionResult.fromJson(json.decode(str));

String getTransactionResultToJson(GetTransactionResult data) => json.encode(data.toJson());

class GetTransactionResult {
  GetTransactionResult({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int status;
  bool success;
  String msg;
  List<Transaction> data;

  factory GetTransactionResult.fromJson(Map<String, dynamic> json) => GetTransactionResult(
    status: json["status"] == null ? null : json["status"],
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    this.code,
    this.status,
    this.createdDate, this.statusName,
  });
  static const int ON_CART = 0;
  static const int WAITING_PAYMENT = 1;
  static const int PAID = 2;
  static const int DELIVERING = 3;
  static const int CANCEL_ORDER = 4;
  static const int REFUND = 5;
  static const int INIT = 6;
  String code;
  String status;
  DateTime createdDate;
  final String statusName;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    statusName: _getStatusName(int.parse(json["status"]))
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
  };
}

String _getStatusName(int status){
  if(status == Transaction.INIT){
    return "Menunggu pembayaran";
  }else if(status == Transaction.ON_CART){
    return "Di dalam keranjang";
  }else if(status == Transaction.WAITING_PAYMENT){
    return "Menunggu pembayaran";
  }else if(status == Transaction.DELIVERING){
    return "Dikirim";
  }else if(status == Transaction.CANCEL_ORDER){
    return "Order dibatalkan";
  }else if(status == Transaction.REFUND){
    return "Refund";
  }else{
    return "Tidak diketahui $status";
  }
}
