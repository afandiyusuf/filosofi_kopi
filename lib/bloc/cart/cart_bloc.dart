import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({this.cartRepository}) : super(CartInitState());
  CartModel _cartModel = CartModel();

  CartModel get cartModel => _cartModel;
  CartRepository cartRepository;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    yield CartUpdating();

    if (event is UpdateCart) {
      int diffTotal = event.total;
      try {
        diffTotal = _cartModel.getDiffTotal(event.product, event.total);
      } catch (_) {
        yield CartUpdateError(cartModel: null);
      }

      bool status = false;
      try {
        status = await cartRepository.addToCartFnb(event.product.id.toString(),
            diffTotal.toString(), event.store, event.product.notes);
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
        yield CartUpdateError(cartModel: _cartModel);
      }
    }

    if (event is DeleteItemFromCart) {
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
      CartModel newestCartModel;
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
      CartModel newestCartModel;
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
      _cartModel = CartModel();
      yield CartEmptyState();
    }

    if (event is AddTransaction) {
      yield AddingTransaction();
      String response = await cartRepository.addTransactionFnb(
          event.firstName,
          event.lastName,
          event.email,
          event.address,
          event.phone,
          event.subtotal,
          event.totalAmount,
          event.total,
          event.discount,
          event.shipping,
          event.shippingType,
          event.shippingCost,
          event.shippingOrigin,
          event.shippingDestination,
          event.province,
          event.city,
          event.voucher,
          event.latitude,
          event.longitude,
          event.createdDate,
          event.store);
      if(response == 'success'){
        yield AddTransactionSuccess();
      }else{
        yield AddTransactionError(response);
      }
    }

    
  }
}
