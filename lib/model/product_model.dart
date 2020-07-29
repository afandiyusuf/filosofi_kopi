import 'package:filkop_mobile_apps/config.dart';
class ProductModel {
  List<Product> _products = [
    Product(id:1,name:"Perfecto Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Product(id:2,name:"Snack",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Product(id:3,name:"Perfecto Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Product(id:4,name:"Perfecto Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Product(id:5,name:"Snack",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Product(id:6,name:"Perfecto Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Product(id:7,name:"Food",image:"https://picsum.photos/250?image=1",price: "75000",category: 3),
    Product(id:8,name:"Food",image:"https://picsum.photos/250?image=1",price: "75000",category: 3),
  ];
  List<Product> _initProducts;
  ProductModel(){
    _initProducts = List.of(_products);
  }
  int getTotal(){
    return _products.length;
  }

  List<Product> getByCategory(int category){
    _products =  _products.where((element) => element.id == category);
    return _products;
  }
  List<Product> all(){
    _products = List.of(_initProducts);
    return _products;
  }
  List<Product> active(){
    return _products;
  }
  Product getById(int id){
    return _products.firstWhere((element) => element.id == id);
  }
  Product getByIndex(int index){
    return _products[index];
  }
  setByCateogory(int category){
    _products = List.of(_initProducts.where((element) => element.category == category));
    print(_products);
  }
  reset(){
    _products = List.of(_initProducts);
  }

}

class Product{
  final int id;
  final String name;
  final String image;
  final String code;
  final String discount;
  final String price;
  final String discPrice;
  final int category;

  Product({this.id, this.name, this.image, this.price, this.category, this.code, this.discount, this.discPrice});
  factory Product.fromJson(Map<String, dynamic> map){
    return Product(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      discount: map['discount'],
      price: map['price'],
      discPrice: map['disc_price'],
      category: map['cat_id']['category_id'],
      image: imageBaseUrl+map['image']['name'],
    );
  }
}