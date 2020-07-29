import 'package:filkop_mobile_apps/bloc/main_page/main_page_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/store_data/store_data_bloc.dart';
import 'package:filkop_mobile_apps/bloc/store_selected/store_selected_bloc.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  static final String tag = '/main';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final PageController _pageController = PageController();
  final MainPageBloc _mainPageBloc = MainPageBloc();
  final StoreSelectedBloc _storeSelectedBloc = StoreSelectedBloc();
  final OrderBoxBloc _orderBoxBloc = OrderBoxBloc();
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [HomePage(orderBoxBloc: _orderBoxBloc,), Menu(), MerchandisePage(), Profile()];

    return MultiBlocProvider(
        providers: [
          BlocProvider<MainPageBloc>(
            create: (_) => _mainPageBloc,
          ),
          BlocProvider<StoreSelectedBloc>(
            create: (_) => _storeSelectedBloc,
          )
        ],
        child: BlocBuilder<MainPageBloc, int>(
          builder: (context, state) {
            return Scaffold(
              body: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  print("ho");
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
              floatingActionButton: Visibility(
                visible: false,
                child: CartBottom(
                  total: "3",
                  price: "200.000",
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                ),
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

  Future<void> _onItemTapped(BuildContext context, int index) async {
    final SharedPreferences prefs = await _prefs;
    final int selectedStore = prefs.getInt("selectedStore");
    print(selectedStore);
    if (selectedStore == 0 && (index == 1 || index == 2)) {
      Navigator.pushNamed(context, PickOurStoresScreen.tag,arguments: {
        'bloc':_orderBoxBloc
      });
    } else {
       context.bloc<MainPageBloc>().add(index);
       //using this page controller you can make beautiful animation effect
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
