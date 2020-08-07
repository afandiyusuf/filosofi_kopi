import 'package:filkop_mobile_apps/model/product_model.dart';

class CartModel{
  List<CartItem> _allItems = [];
  List<CartItem> get  allItem => _allItems;
  List<CartItem> lastHistory;

  int getTotalItems(){
    int total = 0;
    _allItems.forEach((element) {
      total += element.total;
    });
    return total;
  }

  int getTotalPrice(){
    int totalPrice = 0;
    _allItems.forEach((element) {
      int totalPerProduct = element.total * int.parse(element.product.price);
      totalPrice += totalPerProduct;
    });
    return totalPrice;
  }
  void rollBack(){
    _allItems = List.of(lastHistory);
  }
  int addItem(Product product, int total){
    lastHistory = List.of(_allItems);
    int diffTotal = 0;
    if(_allItems.length != 0) {
      CartItem cartItem = _allItems.firstWhere((el) =>
      el.productId == product.id, orElse: () => null);
      print(cartItem);
      if (cartItem != null) {
        _allItems.forEach((element) {
          if (element.productId == product.id) {
            element.total = total;
            diffTotal = total-element.total;
          }
        }
        );
      }else{
        _allItems.add(CartItem(
            productId: product.id,
            product: product,
            total: total
        ));
        diffTotal = total;
      }
    }else{
      _allItems.add(CartItem(
          productId: product.id,
          product: product,
          total: total
      ));
      diffTotal = total;
    }
    _allItems.removeWhere((element) => element.total == 0);
    return diffTotal;
  }

  int getTotalItemsByIndex(String id){
    CartItem cartItem = _allItems.firstWhere((el) =>
    el.productId == id, orElse: () => null);
    if(cartItem != null){
      print("item ada");
      print(cartItem.total);
      return cartItem.total;
    }else{
      return 0;
    }
  }
}
class CartItem{
  String productId;
  int total;
  Product product;
  CartItem({this.total, this.product, this.productId});
}