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
      int diffTotal = event.total;
      try {
        diffTotal = _cartModel.getDiffTotal(event.product, event.total);
      } catch (_) {
        print("get diff total error");
        yield CartUpdateError(cartModel: null);
      }

      bool status = false;
      try {
        status = await cartRepository.addToCartApparel(event.product.id.toString(),
            diffTotal.toString(), event.store, "");
      } catch (_) {
        print("add to cart api error");
        yield CartUpdateError(cartModel: null);
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
      CartApparelModel newestCartModel;
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
      _cartModel = CartApparelModel();
      yield CartEmptyState();
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
          event.longitude,
          event.store);
      if(response == 'success'){
        yield AddTransactionSuccess();
      }else{
        yield AddTransactionError(response);
      }
    }

    
  }
}
