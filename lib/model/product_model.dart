import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:supercharged/supercharged.dart';

class ProductModel {
  List<Product> products;
  List<Product> _initProducts;
  ProductModel({this.products}){
    _initProducts = List.of(products);
  }
  factory ProductModel.fromJson(data){
    return ProductModel(
        products: List<Product>.from(data.map((item) {
          return Product.fromJson(item);
        }))
    );
  }

  int getTotal(){
    return products.length;
  }

  List<Product> getByCategory(int category){
    products =  products.where((element) => element.id == category.toString());
    return products;
  }
  List<Product> all(){
    products = List.of(_initProducts);
    return products;
  }
  List<Product> active(){
    return products;
  }
  Product getById(int id){
    return products.firstWhere((element) => element.id == id.toString());
  }
  Product getByIndex(int index){
    return products[index];
  }

  void sortByBought(CartModel cartModel) {
    print("sort here");
    print(cartModel.allItems.length);
    print(products.length);


    products.forEach((product) {
      product.bought = 0;
      cartModel.allItems.forEach((cartItem) {
        if(cartItem.menuId == product.id){
          product.bought = cartItem.qty;
        }
      });
    });


    print("start sorting");
    String data = "";
    products.forEach((element) {
      data = "$data,${element.id}:${element.bought} ";
    });
    print(data);

    print("start sorting cart model ${cartModel.allItems.length}");
    data = "";
    cartModel.allItems.forEach((element) {
      data = "$data,${element.menuId} : ${element.qty}";
    });
    print(data);

    products.sort((a,b) => b.bought.compareTo(a.bought));
    
  }
  setByCategory(String category){
    if(category == "All"){
      reset();
    }else {
      products = List.of(
          _initProducts.where((element) => element.categoryText == category));
    }
  }
  reset(){
    products = List.of(_initProducts);
  }

}

class Product{
  final String id;
  final String name;
  final String description;
  final String discount;
  final String price;
  final String originalPrice;
  final String stock;
  final String jenis;
  final String avail;
  final String image;
  final String code;
  final String discPrice;
  final String categoryText;
  final int category;
  String notes = "";
  int bought = 0;

  Product({this.id, this.name, this.image, this.price, this.category, this.code, this.discount, this.discPrice, this.description, this.originalPrice, this.avail , this.jenis, this.stock, this.categoryText});

  factory Product.fromJson(Map<String, dynamic> map){
    return Product(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      discount: map['discount'],
      price: map['price'],
      discPrice: map['disc_price'],
      category: 0,
      image: "https://www.filosofikopi.id/upload/images/product/${map['photo']}",
      stock: map['stock'],
      avail: map['avail'],
      originalPrice: map['original_price'],
      jenis: map['jenis'],
      description: map['description'],
      categoryText: map['category'],
    );
  }
}