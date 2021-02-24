// To parse this JSON data, do
//
//     final transactionsResponse = transactionsResponseFromJson(jsonString);

import 'dart:convert';

GetTransactionsResponse transactionsResponseFromJson(String str) => GetTransactionsResponse.fromJson(json.decode(str));

String transactionsResponseToJson(GetTransactionsResponse data) => json.encode(data.toJson());

class GetTransactionsResponse {
  GetTransactionsResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  final int status;
  final bool success;
  final String msg;
  final Data data;

  factory GetTransactionsResponse.fromJson(Map<String, dynamic> json) => GetTransactionsResponse(
    status: json["status"] == null ? null : json["status"],
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.success,
    this.data,
  });

  final bool success;
  final List<Transaction> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Transaction {

  Transaction({
    this.type,
    this.trans,
    this.cart,
    this.date,
  });

  final Type type;
  final Trans trans;
  final List<Cart> cart;
  final DateTime date;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    trans: json["trans"] == null ? null : Trans.fromJson(json["trans"]),
    cart: json["cart"] == null ? null : List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : typeValues.reverse[type],
    "trans": trans == null ? null : trans.toJson(),
    "cart": cart == null ? null : List<dynamic>.from(cart.map((x) => x.toJson())),
    "date": date == null ? null : date.toIso8601String(),
  };
}

class Cart {
  Cart({
    this.cartId,
    this.name,
    this.productImage,
    this.discount,
    this.price,
    this.qty,
    this.total,
    this.size,
  });

  final String cartId;
  final String name;
  final String productImage;
  final String discount;
  final String price;
  final String qty;
  final String total;
  final String size;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    name: json["name"] == null ? null : json["name"],
    productImage: json["product_image"] == null ? null : json["product_image"],
    discount: json["discount"] == null ? null : json["discount"],
    price: json["price"] == null ? null : json["price"],
    qty: json["qty"] == null ? null : json["qty"],
    total: json["total"] == null ? null : json["total"],
    size: json["size"] == null ? null : json["size"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "name": name == null ? null : name,
    "product_image": productImage == null ? null : productImage,
    "discount": discount == null ? null : discount,
    "price": price == null ? null : price,
    "qty": qty == null ? null : qty,
    "total": total == null ? null : total,
    "size": size == null ? null : size,
  };
}

class Trans {
  Trans({
    this.code,
    this.status,
    this.status_text,
    this.createdDate,
    this.totalHargaProduk,
    this.totalBelanja,
  });
  final String status_text;
  final String code;
  final String status;
  final DateTime createdDate;
  final String totalHargaProduk;
  final String totalBelanja;

  factory Trans.fromJson(Map<String, dynamic> json) => Trans(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    totalHargaProduk: json["total_harga_produk"] == null ? null : json["total_harga_produk"],
    totalBelanja: json["total_belanja"] == null ? null : json["total_belanja"],
      status_text: json["status_text"] == null ? null : json["status_text"]
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "total_harga_produk": totalHargaProduk == null ? null : totalHargaProduk,
    "total_belanja": totalBelanja == null ? null : totalBelanja,
  };
}

enum Type { FNB, APPAREL }

final typeValues = EnumValues({
  "apparel": Type.APPAREL,
  "fnb": Type.FNB
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
