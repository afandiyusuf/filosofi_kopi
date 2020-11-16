import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/main_page/main_page_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/bloc/product/product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/product/product_event.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/cart_bottom.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:filkop_mobile_apps/view/screen/pages/menu.dart';
import 'package:filkop_mobile_apps/view/screen/pages/merchandise.dart';
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

  @override
  void initState() {
    super.initState();
    screens = [HomePage(), Menu(), ApparelPage(), Profile()];
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
            BlocListener<CartBloc,CartState>(
              listener: (context, cartStateListener){
                if(cartStateListener is DeleteItemSuccess){
                  Fluttertoast.showToast(
                      msg: "Hapus item berhasil",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              },
              child: Container(),
            ),
            Expanded(
              child: BlocListener<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartUpdated) {
                    context.bloc<ProductBloc>().add(RefreshProduct());
                  }
                },
                child: BlocBuilder<MainPageBloc, int>(
                  builder: (context, state) {
                    return Scaffold(
                      body: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          context.bloc<MainPageBloc>().add(index);
                        },
                        children: screens,
                      ),
                      bottomNavigationBar: BottomNavigationBar(
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
                            title: Text("HOME", style: _bottomNavBarStyle()),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.restaurant_menu),
                            title: Text("MENU", style: _bottomNavBarStyle()),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.show_chart),
                            title: Text("MERCHANDHISE", style: _bottomNavBarStyle()),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.menu),
                            title: Text("PROFILE", style: _bottomNavBarStyle()),
                          ),
                        ],
                      ),
                      floatingActionButton:
                          BlocBuilder<CartBloc, CartState>(builder: (context, state) {

                            if(state is CartInitState){
                              fetchCart(context);
                            }
                        if (state is CartUpdated) {
                          int totalItems = state.cartModel.getTotalItems();
                          int totalPrice = state.cartModel.getTotalPrice();
                          return CartBottom(
                            total: "$totalItems",
                            price: "${rupiah(totalPrice.toDouble())}",
                            onPressed: () {
                              _showBottomSheet(context);
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  TextStyle _bottomNavBarStyle() {
    return TextStyle(fontSize: 9);
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

  void _goToConfirmButton(context) {
    Navigator.pushNamed(context, ConfirmOrder.tag);
  }

  void fetchCart(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String location = pref.getString('location');
    int storeId = pref.getInt('storeId');
    if(location != null) {
      context.bloc<CartBloc>().add(FetchCart(location: location));
      context.bloc<OrderBoxBloc>().add(
          OrderBoxUpdateLocation(location: location, storeId: storeId));
    }
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartInitState) {
              fetchCart(context);
            }

            if (state is CartEmptyState) {
              return Container(
                child: Center(child: Text("Cart Kosong")),
              );
            }

            if (state is CartUpdated) {
              CartModel cartModel = state.cartModel;
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
                              _goToConfirmButton(context);
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
      BuildContext context, String name, String cartId, String store) async {
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
            context
                .bloc<CartBloc>()
                .add(DeleteItemFromCart(cartId: cartId, store: store));
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

  _goToDetail(Product product, BuildContext context) {
    int total = 0;
    if (context.bloc<CartBloc>().state is CartUpdated) {
      CartUpdated state = context.bloc<CartBloc>().state;
      if (state.cartModel != null) {
        //get total menu
        total = state.cartModel.getTotalItemsByIndex(product.id);
      }
    }
    context
        .bloc<OrderBoxBloc>()
        .add(OrderBoxSelectProduct(selectedProduct: product, total: total));
    Navigator.pushNamed(context, DetailPageScreen.tag);
  }
}
