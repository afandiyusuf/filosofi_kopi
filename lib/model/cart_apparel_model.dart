import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';

class CartApparelModel {
  List<CartItem> allProductItems = [];
  List<CartItem> lastHistory;
  int subtotal;
  int total;
  Gosend selectedGosend;
  CartApparelModel({this.allProductItems});

  factory CartApparelModel.fromJson(data, location){
    return CartApparelModel(
        allProductItems: List<CartItem>.from(data.map((item) {
          return CartItem.fromJson(item);
        }))
    );
  }

  int getTotalItems() {
    int total = 0;
    allProductItems.forEach((element) {
      total += element.amount.toInt();
    });
    return total;
  }

  int getTotalTypeItems() {
    return allProductItems.length;
  }

  CartItem getCartItemByIndex(int index) {
    return allProductItems[index];
  }
  CartItem getCartItemByApparel(Apparel product){
    CartItem item =  allProductItems.firstWhere((element) => element.menuId == product.id, orElse: ()=> null);
    return item;
  }


  int getTotalPrice() {
    int totalPrice = 0;
    allProductItems.forEach((element) {
      int totalPerProduct = 0;
      if(element.productPrice != null) {
        totalPerProduct = element.amount.toInt() *
            int.parse(element.productPrice);
      }
      totalPrice += totalPerProduct;
    });
    print(allProductItems);
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


  int getDiffTotal(Apparel product, int total) {
    lastHistory = List.of(allProductItems);
    int diffTotal = 0;

    if (allProductItems.length != 0) {
      CartItem cartItem = allProductItems.firstWhere((el) =>
      el.menuId == product.id, orElse: () => null);
      print(cartItem);
      if (cartItem != null) {
        allProductItems.forEach((element) {
          if (element.menuId == product.id) {
            diffTotal = total - element.amount.toInt();
            element.amount = total;
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
      print(cartItem.amount);
      return cartItem.amount.toInt();
    } else {
      return 0;
    }
  }
}


class CartItem {
  final String cartId;
  final String menuId;
  String notes;
  int amount;
  final String productPrice;
  final String menuDiscount;
  final String name;
  final String photo;
  final String description;
  String total;

  CartItem(
      {this.photo, this.total, this.productPrice, this.menuDiscount, this.name, this.amount, this.menuId, this.cartId, this.notes, this.description});

  factory CartItem.fromJson(data){
    return CartItem(
        cartId: data['cart_id'],
        notes: data['notes'] == null ? null : data['notes'],
        menuId: data['menu_id']  == null ? null : data['menu_id'],
        amount: data['amount'] == null ? null : int.parse(data['amount']),
        productPrice: data['product_price'] == null ? null : data['product_price'] ,
        menuDiscount: data['menu_discount']  == null ? null : data['menu_discount'],
        name: data['name']  == null ? null : data['name'],
        photo: data['photo'] == null ? null : "${data['link_image']}${data['photo']}",
        total: data['total']  == null ? null : data['total'],
        description: data['description']  == null ? null : data['description']
    );
  }

  Product convertToProduct() {
    return Product(
      id: menuId,
      name: name,
      price: productPrice,
      image: photo,
      description: description,
    );
  }
}