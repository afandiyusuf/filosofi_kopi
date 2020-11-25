// To parse this JSON data, do
//
//     final getTransactionDetailResult = getTransactionDetailResultFromJson(jsonString);

import 'dart:convert';

GetTransactionDetailResult getTransactionDetailResultFromJson(String str) => GetTransactionDetailResult.fromJson(json.decode(str));

String getTransactionDetailResultToJson(GetTransactionDetailResult data) => json.encode(data.toJson());

class GetTransactionDetailResult {
  GetTransactionDetailResult({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int status;
  bool success;
  String msg;
  TransactionDetail data;

  factory GetTransactionDetailResult.fromJson(Map<String, dynamic> json) => GetTransactionDetailResult(
    status: json["status"] == null ? null : json["status"],
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : TransactionDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data.toJson(),
  };
}

class TransactionDetail {
  TransactionDetail({
    this.cart,
    this.transaction,
    this.invoice,
  });

  List<CartItemTransactionDetail> cart;
  List<UserDetailTransaction> transaction;
  dynamic invoice;

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
    cart: json["cart"] == null ? null : List<CartItemTransactionDetail>.from(json["cart"].map((x) => CartItemTransactionDetail.fromJson(x))),
    transaction: json["transaction"] == null ? null : List<UserDetailTransaction>.from(json["transaction"].map((x) => UserDetailTransaction.fromJson(x))),
    invoice: json["invoice"],
  );

  Map<String, dynamic> toJson() => {
    "cart": cart == null ? null : List<dynamic>.from(cart.map((x) => x.toJson())),
    "transaction": transaction == null ? null : List<dynamic>.from(transaction.map((x) => x.toJson())),
    "invoice": invoice,
  };
}

class CartItemTransactionDetail {
  CartItemTransactionDetail({
    this.cartId,
    this.name,
    this.productImage,
    this.discount,
    this.price,
    this.qty,
    this.total,
  });

  String cartId;
  String name;
  String productImage;
  String discount;
  String price;
  String qty;
  String total;

  factory CartItemTransactionDetail.fromJson(Map<String, dynamic> json) => CartItemTransactionDetail(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    name: json["name"] == null ? null : json["name"],
    productImage: json["product_image"] == null ? null : json["product_image"],
    discount: json["discount"] == null ? null : json["discount"],
    price: json["price"] == null ? null : json["price"],
    qty: json["qty"] == null ? null : json["qty"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "name": name == null ? null : name,
    "product_image": productImage == null ? null : productImage,
    "discount": discount == null ? null : discount,
    "price": price == null ? null : price,
    "qty": qty == null ? null : qty,
    "total": total == null ? null : total,
  };
}

class UserDetailTransaction {
  UserDetailTransaction({
    this.code,
    this.fullname,
    this.shippingCost,
    this.shippingType,
    this.address,
    this.city,
    this.province,
    this.subtotal,
    this.discount,
    this.total,
  });

  String code;
  String fullname;
  String shippingCost;
  String shippingType;
  String address;
  String city;
  String province;
  String subtotal;
  String discount;
  String total;

  factory UserDetailTransaction.fromJson(Map<String, dynamic> json) => UserDetailTransaction(
    code: json["code"] == null ? null : json["code"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    shippingCost: json["shipping_cost"] == null ? null : json["shipping_cost"],
    shippingType: json["shipping_type"] == null ? null : json["shipping_type"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    province: json["province"] == null ? null : json["province"],
    subtotal: json["subtotal"] == null ? null : json["subtotal"],
    discount: json["discount"] == null ? null : json["discount"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "fullname": fullname == null ? null : fullname,
    "shipping_cost": shippingCost == null ? null : shippingCost,
    "shipping_type": shippingType == null ? null : shippingType,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "province": province == null ? null : province,
    "subtotal": subtotal == null ? null : subtotal,
    "discount": discount == null ? null : discount,
    "total": total == null ? null : total,
  };
}
