import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  CartBloc({this.cartRepository}) : super(CartEmptyState());
  CartModel _cartModel = CartModel();
  CartRepository cartRepository;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    yield CartUpdating();
    if(event is UpdateCart){
      int diffTotal = _cartModel.addItem(event.product, event.total);
      bool status = await cartRepository.addToCartFnb(1147.toString(), event.product.id.toString(), diffTotal.toString(), event.store, event.product.notes);

      if(status){
        yield CartUpdated(cartModel: _cartModel);
      }else{
        _cartModel.rollBack();
        yield CartUpdateError(cartModel: _cartModel);
      }
    }
    if(event is DisposeCartEvent){
      _cartModel = CartModel();
      yield CartEmptyState();
    }
  }

}