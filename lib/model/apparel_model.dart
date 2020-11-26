import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:filkop_mobile_apps/model/cart_product_model.dart';

class ApparelModel {
  List<Apparel> products;
  List<Apparel> _initProducts;
  ApparelModel({this.products}){
    _initProducts = List.of(products);
  }
  factory ApparelModel.fromJson(data){
    return ApparelModel(
        products: List<Apparel>.from(data.map((item) {
          return Apparel.fromJson(item);
        }))
    );
  }

  int getTotal(){
    return products.length;
  }

  List<Apparel> getByCategory(int category){
    products =  products.where((element) => element.id == category.toString());
    return products;
  }
  List<Apparel> all(){
    products = List.of(_initProducts);
    return products;
  }
  List<Apparel> active(){
    return products;
  }
  Apparel getById(int id){
    return products.firstWhere((element) => element.id == id.toString());
  }
  Apparel getByIndex(int index){
    return products[index];
  }

  void sortByBought(CartApparelModel cartModel) {
    print("sort here");
    print(cartModel.allProductItems.length);
    print(products.length);


    products.forEach((product) {
      product.bought = 0;
      cartModel.allProductItems.forEach((cartItem) {
        if(cartItem.productId == product.id){
          product.bought = cartItem.amount;
        }
      });
    });


    print("start sorting");
    String data = "";
    products.forEach((element) {
      data = "$data,${element.id}:${element.bought} ";
    });
    print(data);

    print("start sorting cart model ${cartModel.allProductItems.length}");
    data = "";
    cartModel.allProductItems.forEach((element) {
      data = "$data,${element.productId} : ${element.amount}";
    });
    print(data);

    products.sort((a,b) => b.bought.compareTo(a.bought));

  }
  setByCategory(int category){
    reset();
    if(category == 0){
      reset();
    }else {
      String categoryString = "$category";
      products = List.of(
          _initProducts.where((element) => element.catId[0].categoryId == categoryString));
    }
  }
  reset(){
    products = List.of(_initProducts);
  }

}


class Apparel {
  Apparel({
    this.id,
    this.code,
    this.name,
    this.discount,
    this.price,
    this.discPrice,
    this.catId,
    this.image,
    this.avail,
    this.preorder,
  });

  final String id;
  final String code;
  final String name;
  final String discount;
  final String price;
  final String discPrice;
  final List<CatId> catId;
  final List<Image> image;
  final String avail;
  final String preorder;
  int bought = 0;

  factory Apparel.fromJson(Map<String, dynamic> json) => Apparel(
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    discount: json["discount"] == null ? null : json["discount"],
    price: json["price"] == null ? null : json["price"],
    discPrice: json["disc_price"] == null ? null : json["disc_price"],
    catId: json["cat_id"] == null ? null : List<CatId>.from(json["cat_id"].map((x) => CatId.fromJson(x))),
    image: json["image"] == null ? null : List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
    avail: json["avail"] == null ? null : json["avail"],
    preorder: json["preorder"] == null ? null : json["preorder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "name": name == null ? null : name,
    "discount": discount == null ? null : discount,
    "price": price == null ? null : price,
    "disc_price": discPrice == null ? null : discPrice,
    "cat_id": catId == null ? null : List<dynamic>.from(catId.map((x) => x.toJson())),
    "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
    "avail": avail == null ? null : avail,
    "preorder": preorder == null ? null : preorder,
  };
}

class CatId {
  CatId({
    this.id,
    this.productId,
    this.categoryId,
  });

  final String id;
  final String productId;
  final String categoryId;

  factory CatId.fromJson(Map<String, dynamic> json) => CatId(
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

  final String id;
  final String productId;
  final String linkImage;
  final String name;

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