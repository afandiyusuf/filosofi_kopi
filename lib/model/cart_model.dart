import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';

class CartModel {
  List<CartItem> allProductItems = [];
  List<CartItem> allApparelItems = [];
  List<CartItem> lastHistory;
  int subtotal;
  int total;
  Gosend selectedGosend;
  CartModel({this.allProductItems});

  factory CartModel.fromJson(data, location){
    return CartModel(
        allProductItems: List<CartItem>.from(data.map((item) {
          return CartItem.fromJson(item);
        }))
    );
  }

  int getTotalItems() {
    int total = 0;
    allProductItems.forEach((element) {
      total += element.qty.toInt();
    });
    return total;
  }

  int getTotalTypeItems() {
    return allProductItems.length;
  }

  CartItem getCartItemByIndex(int index) {
    return allProductItems[index];
  }
  CartItem getCartItemByProduct(Product product){
    CartItem item =  allProductItems.firstWhere((element) => element.menuId == product.id, orElse: ()=> null);
    return item;
  }
  
  CartItem getCartItemByAppare(Apparel product){
    CartItem item = allApparelItems.firstWhere((element) => element.menuId == product.id, orElse: ()=>null);
    return item;
  }


  int getTotalPrice() {
    int totalPrice = 0;
    allProductItems.forEach((element) {
      int totalPerProduct = element.qty.toInt() * int.parse(element.menuPrice);
      totalPrice += totalPerProduct;
    });
    subtotal = totalPrice;
    return totalPrice;
  }

  void calculateTotalWithDelivery(){
    getTotalPrice();
    if(selectedGosend != null) {
      total = subtotal + selectedGosend.price;
    }else{
      total = subtotal;
    }

  }

  void rollBack() {
    allProductItems = List.of(lastHistory);
  }


  int getDiffTotal(Product product, int total) {
    lastHistory = List.of(allProductItems);
    int diffTotal = 0;

    if (allProductItems.length != 0) {
      CartItem cartItem = allProductItems.firstWhere((el) =>
      el.menuId == product.id, orElse: () => null);
      print(cartItem);
      if (cartItem != null) {
        allProductItems.forEach((element) {
          if (element.menuId == product.id) {
            diffTotal = total - element.qty.toInt();
            element.qty = total;
          }
        }
        );
      } else {
        diffTotal = total;
      }
    } else {
      diffTotal = total;
    }
    return diffTotal;
  }

  int getTotalItemsByIndex(String id) {
    CartItem cartItem = allProductItems.firstWhere((el) =>
    el.menuId == id, orElse: () => null);
    if (cartItem != null) {
      print(cartItem.qty);
      return cartItem.qty.toInt();
    } else {
      return 0;
    }
  }
}

class CartItem {
  final String cartId;
  final String menuId;
  String notes;
  int qty;
  final String menuPrice;
  final String menuDiscount;
  final String name;
  final String photo;
  final String description;
  String total;

  CartItem(
      {this.photo, this.total, this.menuPrice, this.menuDiscount, this.name, this.qty, this.menuId, this.cartId, this.notes, this.description});

  factory CartItem.fromJson(data){
    return CartItem(
        cartId: data['cart_id'],
        notes: data['notes'],
        menuId: data['menu_id'],
        qty: int.parse(data['qty']),
        menuPrice: data['menu_price'],
        menuDiscount: data['menu_discount'],
        name: data['name'],
        photo: "${data['link_image']}${data['photo']}",
        total: data['total'],
        description: data['description']
    );
  }

  Product convertToProduct() {
    return Product(
      id: menuId,
      name: name,
      price: menuPrice,
      image: photo,
      description: description,
    );
  }
}