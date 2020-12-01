import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_state.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_state.dart' as CartApparelState;
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_event.dart' as CartApparelEvent;
import 'package:filkop_mobile_apps/bloc/main_page/main_page_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/bloc/product/product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/product/product_event.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/cart_apparel_model.dart' as CartApparelModel;
import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/cart_bottom.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order_apparel.dart';
import 'package:filkop_mobile_apps/view/screen/detail_apparel_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_product_screen.dart';
import 'package:filkop_mobile_apps/view/screen/pages/apparel_page.dart';
import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:filkop_mobile_apps/view/screen/pages/product_page.dart';
import 'package:filkop_mobile_apps/view/screen/pages/profile.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';

class MainScreen extends StatefulWidget {
  static final String tag = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  List<Widget> screens;
  int _pageIndex = 0;
  String _cartId;
  @override
  void initState() {
    super.initState();
    screens = [HomePage(), ProductPage(), ApparelPage(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainPageBloc>(
            create: (_) => MainPageBloc(),
          )
        ],
        child: Column(
          children: [
            BlocListener<CartProductBloc, CartProductState>(
              listener: (context, cartStateListener) {
                if (cartStateListener is DeleteItemSuccess) {
                  Fluttertoast.showToast(
                      msg: "Hapus item berhasil",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Container(),
            ),
            BlocListener<CartApparelBloc, CartApparelState.CartApparelState>(
              listener: (context, cartStateListener) {
                if (cartStateListener is CartApparelState.DeleteItemSuccess) {
                  Fluttertoast.showToast(
                      msg: "Hapus item berhasil",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Container(),
            ),
            Expanded(
              child: BlocListener<CartProductBloc, CartProductState>(
                listener: (context, state) {
                  if (state is CartUpdated) {
                    context.bloc<ProductBloc>().add(RefreshProduct());
                  }
                },
                child: BlocBuilder<MainPageBloc, int>(
                  builder: (context, state) {
                    return Scaffold(
                      body: Stack(
                        children: [
                          SafeArea(
                            child: PageView(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  _pageIndex = index;
                                });
                                context.bloc<MainPageBloc>().add(index);
                              },
                              children: screens,
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: (_pageIndex == 2)? true:false,
                                  child: BlocBuilder<CartApparelBloc, CartApparelState.CartApparelState>(
                                      builder: (context, state) {
                                        if (state is CartApparelState.CartInitState) {
                                          fetchCartApparel(context);
                                        }
                                        if (state is CartApparelState.CartUpdated) {
                                          int totalItems = state.cartModel.getTotalItems();
                                          int totalPrice = state.cartModel.getTotalPrice();
                                          return Container(
                                            child: CartBottom(
                                              total: "$totalItems",
                                              price: "${rupiah(totalPrice.toDouble())}",
                                              onPressed: () {
                                                _showBottomSheetApparel(context);
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),

                                //FNB CART
                                Visibility(
                                  visible: (_pageIndex == 1)? true:false,
                                  child: BlocBuilder<CartProductBloc, CartProductState>(
                                      builder: (context, state) {
                                        if (state is CartInitState) {
                                          fetchCart(context);
                                        }
                                        if (state is CartUpdated) {
                                          int totalItems = state.cartModel.getTotalItems();
                                          int totalPrice = state.cartModel.getTotalPrice();
                                          return CartBottom(
                                            total: "$totalItems",
                                            price: "${rupiah(totalPrice.toDouble())}",
                                            onPressed: () {
                                              _showBottomSheetProduct(context);
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        unselectedLabelStyle: TextStyle(fontSize: 9),
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.black,
                        selectedLabelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        currentIndex: state,
                        onTap: (index) {
                          context.bloc<MainPageBloc>().add(index);
                          _onItemTapped(context, index);
                        },
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: "Home",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.restaurant_menu),
                            label: "Menu",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.show_chart),
                            label: "Apparel",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.menu),
                            label: "Profile",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }


  _onItemTapped(BuildContext context, int index) {
    if (context.bloc<OrderBoxBloc>().state is OrderBoxDefault &&
        (index == 1 || index == 2)) {
      Navigator.pushNamed(context, PickOurStoresScreen.tag);
      _pageController.jumpToPage(0);
      context.bloc<MainPageBloc>().add(0);
    } else {
      context.bloc<MainPageBloc>().add(index);
      _pageController.jumpToPage(index);
    }
  }

  void _goToConfirmButton(context, String destination) {
    Navigator.pushNamed(context,destination);
  }

  void fetchCart(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String location = pref.getString('location');
    int storeId = pref.getInt('storeId');
    if (location != null) {
      context.bloc<CartProductBloc>().add(FetchCart(location: location));
      context
          .bloc<OrderBoxBloc>()
          .add(OrderBoxUpdateLocation(location: location, storeId: storeId));
    }
  }
  void fetchCartApparel(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String location = pref.getString('location');
    if (location != null) {
      context.bloc<CartApparelBloc>().add(CartApparelEvent.FetchCart(location: location));
    }
  }
  void _showBottomSheetApparel(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<CartApparelBloc, CartApparelState.CartApparelState>(
              builder: (context, state) {
                if (state is CartApparelState.CartInitState) {
                  fetchCart(context);
                }

                if (state is CartApparelState.CartEmptyState) {
                  return Container(
                    child: Center(child: Text("Cart Kosong")),
                  );
                }

                if (state is CartApparelState.CartUpdated) {
                  CartApparelModel.CartApparelModel cartModel = state.cartModel;

                  return Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Text("Shopping Cart"),
                              ),
                              Divider(
                                height: 5,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: cartModel.getTotalTypeItems(),
                                  itemBuilder: (BuildContext context, int index) {
                                    CartApparelModel.CartItem cartItem =
                                    cartModel.getCartItemByIndex(index);
                                    return ListTileOrder(
                                        name: "${cartItem.name}",
                                        price: rupiah(cartItem.total.toDouble()),
                                        total: cartItem.amount.toString(),
                                        image: cartItem.photo,
                                        size: cartItem.size,
                                        onTap: () {
                                          _goToDetail(
                                              null, context,isProduct :false, apparel: cartItem );
                                        },
                                        onDeleteTap: () async {
                                          SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                          String location =
                                          pref.getString('location');
                                          _showAlertDelete(context, cartItem.name,
                                              cartItem.cartId, location,isApparel: true);
                                        });
                                  },
                                ),
                              ),
                              CartBottom(
                                onPressed: () {
                                  _goToConfirmButton(context, ConfirmOrderApparel.tag);
                                },
                                total: cartModel.getTotalItems().toString(),
                                price: rupiah(cartModel.getTotalPrice().toDouble()),
                                marginBottom: 0,
                              )
                            ],
                          )));
                }

                if (state is CartUpdating) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CartEmptyState) {
                  return Container();
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        });
  }


  void _showBottomSheetProduct(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<CartProductBloc, CartProductState>(
              builder: (context, state) {
            if (state is CartInitState) {
              fetchCart(context);
            }

            if (state is CartEmptyState) {
              return Container(
                child: Center(child: Text("Cart Kosong")),
              );
            }

            if (state is CartUpdated) {
              CartProductModel cartModel = state.cartModel;
              return Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Text("Shopping Cart"),
                          ),
                          Divider(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cartModel.getTotalTypeItems(),
                              itemBuilder: (BuildContext context, int index) {
                                CartItem cartItem =
                                    cartModel.getCartItemByIndex(index);
                                return ListTileOrder(
                                    name: cartItem.name,
                                    price: rupiah(cartItem.total.toDouble()),
                                    total: cartItem.qty.toString(),
                                    image: cartItem.photo,
                                    onTap: () {
                                      _goToDetail(
                                          cartItem.convertToProduct(), context);
                                    },
                                    onDeleteTap: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      String location =
                                          pref.getString('location');
                                      _showAlertDelete(context, cartItem.name,
                                          cartItem.cartId, location);
                                    });
                              },
                            ),
                          ),
                          CartBottom(
                            onPressed: () {
                              _goToConfirmButton(context, ConfirmOrder.tag);
                            },
                            total: cartModel.getTotalItems().toString(),
                            price: rupiah(cartModel.getTotalPrice().toDouble()),
                            marginBottom: 0,
                          )
                        ],
                      )));
            }

            if (state is CartUpdating) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartEmptyState) {
              return Container();
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          });
        });
  }

  _showAlertDelete(
      BuildContext context, String name, String cartId, String store, {bool isApparel = false}) async {
    print("here");
    print("$cartId, $store");
    await animated_dialog_box.showInOutDailog(
        title: Center(child: Text("Warning")),
        // IF YOU WANT TO ADD
        context: context,
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.red,
          child: Text('Ya, Hapus!'),
          onPressed: () {
            if(isApparel) {
              context
                  .bloc<CartApparelBloc>()
                  .add(CartApparelEvent.DeleteApparelItemFromCart(cartId: cartId, store: store));
            }else {
              context
                  .bloc<CartProductBloc>()
                  .add(DeleteProductItemFromCart(cartId: cartId, store: store));
            }
            Navigator.of(context).pop();
          },
        ),
        secondButton: MaterialButton(
          // OPTIONAL BUTTON
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
        ),
        // IF YOU WANT TO ADD ICON
        yourWidget: Container(
          child: Text(
              'Apa kamu yakin ingin menghapus ($name) dari keranjang belanjaan kamu?'),
        ));
  }

  _goToDetail(Product product, BuildContext context,{bool isProduct = true, CartApparelModel.CartItem apparel}) {
    if(isProduct) {
      int total = 0;
      if (context
          .bloc<CartProductBloc>()
          .state is CartUpdated) {
        CartUpdated state = context
            .bloc<CartProductBloc>()
            .state;
        if (state.cartModel != null) {
          //get total menu
          total = state.cartModel.getTotalItemsByIndex(product.id);
        }
      }
      context
          .bloc<OrderBoxBloc>()
          .add(OrderBoxSelectProduct(selectedProduct: product, total: total));
      Navigator.pushNamed(context, DetailProductScreen.tag);
    }else{
      int total = 0;
      if (context
          .bloc<CartApparelBloc>()
          .state is CartApparelState.CartUpdated) {
        CartApparelState.CartUpdated state = context
            .bloc<CartApparelBloc>()
            .state;
        if (state.cartModel != null) {
          //get total menu
          total = state.cartModel.getTotalByCartId(apparel.cartId);
          CartApparelModel.CartApparelModel cartModel = state.cartModel;

          context.bloc<OrderBoxBloc>().add(OrderBoxSelectApparel(selectedApparel: apparel.convertToApparel(),total: total, cartId: apparel.cartId));
          Navigator.pushNamed(context, DetailApparelScreen.tag);
        }
      }
    }
  }
}
