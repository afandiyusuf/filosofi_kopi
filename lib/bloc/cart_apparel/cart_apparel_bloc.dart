import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_state.dart';
import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:filkop_mobile_apps/repository/cart_apparel_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartApparelBloc extends Bloc<CartApparelEvent, CartApparelState> {

  CartApparelModel _cartModel = CartApparelModel();

  CartApparelModel get cartModel => _cartModel;
  CartApparelRepository cartRepository;


  CartApparelBloc({this.cartRepository}) : super(CartInitState());

  @override
  Stream<CartApparelState> mapEventToState(CartApparelEvent event) async* {
    yield CartUpdating();

    if (event is UpdateApparelCart) {

      if(event.cartId != null){
        //delete first
        await cartRepository.deleteItemApparelFromCart(event.cartId);
        print("DELETE SUCCESS");
      }
      bool status = false;
      try {
        status = await cartRepository.addToCartApparel(event.product.id.toString(),
            event.total.toString(), event.store, "", event.size);
      } catch (_) {
        print("add to cart api error");
        yield CartUpdateError(cartModel: null);
        return;
      }
      if (status) {
        //refresh cart
        _cartModel = await cartRepository.getCart(event.store);
        if (_cartModel != null) {
          yield CartUpdated(cartModel: _cartModel);
          return;
        } else {
          yield CartEmptyState();
          return;
        }
      } else {
        _cartModel.rollBack();
        yield CartUpdated(cartModel: _cartModel);
        return;
      }
    }

    if (event is DeleteApparelItemFromCart) {
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
      CartApparelModel newestCartModel;
      newestCartModel = await cartRepository.getCart(event.store);
      if (newestCartModel != null) {
        print("finish update cart here");
        _cartModel = newestCartModel;
        yield CartUpdated(cartModel: _cartModel);
        return;
      } else {
        print("cart empty");
        _cartModel = null;
        yield CartEmptyState();
        return;
      }
    }

    if (event is UpdateDeliveryMethodCart) {
      print("UPDATING HERE");
      _cartModel.selectedDelivery = event.deliverySelected;
      _cartModel.calculateTotalWithDelivery();
      _cartModel.selectedDeliveryResult = event.deliveryResultSelected;
      yield CartUpdated(cartModel: _cartModel);
      return;
    }

    if (event is FetchCart) {
      CartApparelModel newestCartModel;
      newestCartModel = await cartRepository.getCart(event.location);
      if (newestCartModel != null) {
        print("finish update cart here");
        _cartModel = newestCartModel;
        print(_cartModel);
        yield CartUpdated(cartModel: _cartModel);
        return;
      } else {
        print("cart empty");
        yield CartEmptyState();
        return;
      }
    }

    if (event is DisposeCartEvent) {
      _cartModel = CartApparelModel();
      yield CartEmptyState();
      return;
    }

    if (event is AddTransaction) {
      yield AddingTransaction();
      String response = await cartRepository.addTransactionApparel(
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
          event.longitude);
      if(response == 'success'){
        yield AddTransactionSuccess();
        return;
      }else{
        print("ADD TRANSACTION ERROR FROM BLOC");
        yield AddTransactionError(response);
        return;
      }
    }

    if(_cartModel == null){
      yield CartEmptyState();
      return;
    }
    if(_cartModel.allProductItems != null) {
      if (_cartModel.allProductItems.length > 0) {
        yield CartUpdated(cartModel: _cartModel);
        return;
      } else {
        yield CartEmptyState();
        return;
      }
    }
  }
}
