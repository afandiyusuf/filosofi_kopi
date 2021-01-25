// To parse this JSON data, do
//
//     final detailApparelResponse = detailApparelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:supercharged/supercharged.dart';

DetailApparelResponse detailApparelResponseFromJson(String str) => DetailApparelResponse.fromJson(json.decode(str));

String detailApparelResponseToJson(DetailApparelResponse data) => json.encode(data.toJson());

class DetailApparelResponse {
  DetailApparelResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int status;
  bool success;
  String msg;
  DetailApparel data;

  factory DetailApparelResponse.fromJson(Map<String, dynamic> json) => DetailApparelResponse(
    status: json["status"] == null ? null : json["status"],
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : DetailApparel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data.toJson(),
  };
}

class DetailApparel {
  DetailApparel({
    this.id,
    this.code,
    this.name,
    this.discount,
    this.discPrice,
    this.price,
    this.description,
    this.materials,
    this.weight,
    this.showSize,
    this.link,
    this.preorder,
    this.category,
    this.stock,
    this.image,
  });

  String id;
  String code;
  String name;
  String discount;
  String discPrice;
  String price;
  String description;
  String materials;
  String weight;
  String showSize;
  String link;
  String preorder;
  List<Category> category;
  Stock stock;
  List<Image> image;

  factory DetailApparel.fromJson(Map<String, dynamic> json) => DetailApparel(
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    discount: json["discount"] == null ? null : json["discount"],
    discPrice: json["disc_price"] == null ? null : json["disc_price"],
    price: json["price"] == null ? null : json["price"],
    description: json["description"] == null ? null : json["description"],
    materials: json["materials"] == null ? null : json["materials"],
    weight: json["weight"] == null ? null : json["weight"],
    showSize: json["show_size"] == null ? null : json["show_size"],
    link: json["link"] == null ? null : json["link"],
    preorder: json["preorder"] == null ? null : json["preorder"],
    category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    stock: json["stock"] == null ? null : Stock.fromJson(json["stock"]),
    image: json["image"] == null ? null : List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "name": name == null ? null : name,
    "discount": discount == null ? null : discount,
    "disc_price": discPrice == null ? null : discPrice,
    "price": price == null ? null : price,
    "description": description == null ? null : description,
    "materials": materials == null ? null : materials,
    "weight": weight == null ? null : weight,
    "show_size": showSize == null ? null : showSize,
    "link": link == null ? null : link,
    "preorder": preorder == null ? null : preorder,
    "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
    "stock": stock == null ? null : stock.toJson(),
    "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.productId,
    this.categoryId,
  });

  String id;
  String productId;
  String categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_id": productId == null ? null : productId,
    "category_id": categoryId == null ? null : categoryId,
  };
}

class Image {
  Image({
    this.id,
    this.productId,
    this.linkImage,
    this.name,
  });

  String id;
  String productId;
  String linkImage;
  String name;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"] == null ? null : json["id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    linkImage: json["link_image"] == null ? null : json["link_image"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_id": productId == null ? null : productId,
    "link_image": linkImage == null ? null : linkImage,
    "name": name == null ? null : name,
  };
}

class Stock {
  Stock({
    this.s,
    this.m,
    this.l,
    this.xl,
    this.xxl,
    this.stock
  });

  updateDepensOnCartItem(List<CartItem> cartItems, String productId){
    if(cartItems != null) {
      cartItems.forEach((element) {
        int totalS = s.toInt();
        int totalM = m.toInt();
        int totalL = l.toInt();
        int totalXL = xl.toInt();
        int totalXXL = xxl.toInt();
        int totalStock = stock.toInt();
        if (element.productId == productId) {
          if (element.size == "s") {
            totalS -= element.amount.toInt();
            s = totalS.toString();
          }else if (element.size == "m") {
            totalM -= m.toInt();
            m = totalM.toString();
          }else if (element.size == "l") {
            totalL -= l.toInt();
            l = totalL.toString();
          }else if (element.size == "xl") {
            totalXL -= xl.toInt();
            xl = totalXL.toString();
          }else if (element.size == "xxl") {
            totalXXL -= xxl.toInt();
            xxl = totalXXL.toString();
          }else {
            print(element.size);
            totalStock -= stock.toInt();
            stock = totalStock.toString();
          }
        }
      });
    }else{
      return;
    }
  }

  String s;
  String m;
  String l;
  String xl;
  String xxl;
  String stock;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    s: json["s"] == null ? null : json["s"],
    m: json["m"] == null ? null : json["m"],
    l: json["l"] == null ? null : json["l"],
    xl: json["xl"] == null ? null : json["xl"],
    xxl: json["xxl"] == null ? null : json["xxl"],
    stock: json["stock"] == null ? null : json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "s": s == null ? null : s,
    "m": m == null ? null : m,
    "l": l == null ? null : l,
    "xl": xl == null ? null : xl,
    "xxl": xxl == null ? null : xxl,
    "stock": stock == null ? null : stock,
  };
}