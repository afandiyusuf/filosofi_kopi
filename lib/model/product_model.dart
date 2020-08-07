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

  Product({this.id, this.name, this.image, this.price, this.category, this.code, this.discount, this.discPrice, this.description, this.originalPrice, this.avail , this.jenis, this.stock, this.categoryText});

  factory Product.fromJson(Map<String, dynamic> map){
    print(map['description']);
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