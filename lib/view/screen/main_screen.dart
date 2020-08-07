import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/main_page/main_page_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_state.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/cart_bottom.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order.dart';
import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:filkop_mobile_apps/view/screen/pages/menu.dart';
import 'package:filkop_mobile_apps/view/screen/pages/merchandise.dart';
import 'package:filkop_mobile_apps/view/screen/pages/profile.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
     screens = [
      HomePage(),
      Menu(),
      MerchandisePage(),
      Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainPageBloc>(
            create: (_) => MainPageBloc(),
          )
        ],
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
                onTap: (index){
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
              floatingActionButton: BlocBuilder<CartBloc,CartState>(
                builder: (context, state) {
                  if (state is CartUpdated) {
                    print("updated bos");
                    int totalItems = state.cartModel.getTotalItems();
                    int totalPrice = state.cartModel.getTotalPrice();
                    return CartBottom(
                      total: "$totalItems",
                      price: "$totalPrice",
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                    );
                  } else {
                    return Container();
                  }
                }
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          },
        ));
  }

  TextStyle _bottomNavBarStyle() {
    return TextStyle(fontSize: 9);
  }

  _onItemTapped(BuildContext context, int index){
      if (context.bloc<OrderBoxBloc>().state is OrderBoxDefault && (index == 1 || index == 2)) {
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

  void _showBottomSheet(context) {
    ProductModel pm = new ProductModel();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: pm.getTotal(),
                          itemBuilder: (BuildContext context, int index) {
                            Product p = pm.getByIndex(index);
                            return ListTileOrder(
                              name: p.name,
                              price: p.price.toString(),
                              total: 2.toString(),
                              image: p.image,
                            );
                          },
                        ),
                      ),
                      CartBottom(
                        onPressed: () {
                          _goToConfirmButton(context);
                        },
                        total: "30",
                        price: "20.000.000",
                        marginBottom: 0,
                      )
                    ],
                  )));
        });
  }
}
