import 'dart:convert';

import 'package:filkop_mobile_apps/bloc/cart/cart_product_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_state.dart';
import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  CartProductBloc({this.cartRepository}) : super(CartInitState());
  CartProductModel _cartModel = CartProductModel();

  CartProductModel get cartModel => _cartModel;
  CartRepository cartRepository;

  @override
  Stream<CartProductState> mapEventToState(CartProductEvent event) async* {
    yield CartUpdating();

    if (event is UpdateProductCart) {
      int diffTotal = event.total;
      try {
        diffTotal = _cartModel.getDiffTotal(event.product, event.total);
      } catch (_) {
        print("get diff total error");
//        yield CartUpdateError(cartModel: null);
      }

      bool status = false;
      try {
        status = await cartRepository.addToCartFnb(event.product.id.toString(),
            diffTotal.toString(), event.store, event.product.notes);
      } catch (_) {
        print("add to cart api error");
        yield CartUpdateError(cartModel: null);
        return;
      }
      print(status);
      if (status) {
        //refresh cart
        _cartModel = await cartRepository.getCart(event.store);
        if (_cartModel != null) {
          yield CartUpdated(cartModel: _cartModel);
        } else {
          yield CartEmptyState();
        }
      } else {
        _cartModel.rollBack();
        yield CartUpdated(cartModel: _cartModel);
      }
    }

    if (event is DeleteProductItemFromCart) {
      bool status = false;
      try {
        status = await cartRepository.deleteItemFromCart(event.cartId);
      } catch (_) {
        print("delete cart error|");
        print(_.toString());
      }
      print(status);
      print("delete cart success");
      yield DeleteItemSuccess();
      CartProductModel newestCartModel;
      newestCartModel = await cartRepository.getCart(event.store);
      if (newestCartModel != null) {
        print("finish update cart here");
        _cartModel = newestCartModel;
        yield CartUpdated(cartModel: _cartModel);
      } else {
        print("cart empty");
        _cartModel = null;
        yield CartEmptyState();
      }
    }

    if (event is UpdateDeliveryMethodCart) {
      _cartModel.selectedGosend = event.deliverySelected;
      _cartModel.calculateTotalWithDelivery();
      yield CartUpdated(cartModel: _cartModel);
    }

    if (event is FetchCart) {
      CartProductModel newestCartModel;
      newestCartModel = await cartRepository.getCart(event.location);
      if (newestCartModel != null) {
        print("finish update cart here");
        _cartModel = newestCartModel;
        print(_cartModel);
        yield CartUpdated(cartModel: _cartModel);
      } else {
        yield CartEmptyState();
      }
    }

    if (event is DisposeCartEvent) {
      _cartModel = CartProductModel();
      yield CartEmptyState();
    }

    if (event is AddTransaction) {
      yield AddingTransaction();
      String response = await cartRepository.addTransactionFnb(
          event.firstName,
          event.lastName,
          event.email,
          event.phone,
          event.addressId,
          event.shipping,
          event.shippingType,
          event.shippingCost,
          event.voucher,
          event.latitude,
          event.longitude,
          event.store);
      final parsed = json.decode(response);
      if(parsed['success'] == true){

        yield AddTransactionSuccess(parsed["data"]);
      }else{
        yield AddTransactionError(response);
      }
    }

    
  }
}
