import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({this.cartRepository}) : super(CartEmptyState());
  CartModel _cartModel = CartModel();
  CartRepository cartRepository;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    yield CartUpdating();
    if (event is UpdateCart) {
      print("Start update local database");
      int diffTotal = event.total;
      try {
        diffTotal = _cartModel.getDiffTotal(event.product, event.total);
      } catch (_) {
        print("get diff total error");
        yield CartUpdateError(cartModel: null);
      }
      print("get diff success");
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
          yield CartUpdated(cartModel: _cartModel);
        }
      } else {
        _cartModel.rollBack();
        yield CartUpdateError(cartModel: _cartModel);
      }
    }
    if(event is DeleteItemFromCart){
      bool status = false;
      try{
        status = await cartRepository.deleteItemFromCart(event.cartId);
      }catch(_){
        print("delete cart error|");
        print(_.toString());
      }
      print(status);
      print("delete cart success");
      CartModel newestCartModel;
      newestCartModel = await cartRepository.getCart(event.store);
      if (newestCartModel != null) {
        print("finish update cart here");
        yield CartUpdated(cartModel: newestCartModel);
      } else {
        yield CartUpdated(cartModel: _cartModel);
      }

    }

    if (event is DisposeCartEvent) {
      _cartModel = CartModel();
      yield CartEmptyState();
    }
  }
}
