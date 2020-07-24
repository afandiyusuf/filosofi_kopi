import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/cart_bottom.dart';
import 'package:filkop_mobile_apps/view/component/list_tile_order.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order.dart';
import 'package:filkop_mobile_apps/view/screen/pages/home.dart';
import 'package:filkop_mobile_apps/view/screen/pages/menu.dart';
import 'package:filkop_mobile_apps/view/screen/pages/merchandise.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static final String tag = '/main';

  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _selectedIndex = 0;
  static final String tag = '/main';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomePage(),
      Menu(),
      MerchandisePage()
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
      floatingActionButton: CartBottom(
        total: "3",
        price: "200.000",
        onPressed: (){
          _showBottomSheet(context);
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  TextStyle _bottomNavBarStyle() {
    return TextStyle(fontSize: 9);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
  void _goToConfirmButton(context){
    Navigator.pushNamed(context, ConfirmOrder.tag);
  }
  void _showBottomSheet(context){
    ProductModel pm = new ProductModel();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pm.getTotal(),
                      itemBuilder: (BuildContext context, int index){
                        Product p = pm.getByIndex(index);
                        return ListTileOrder(name:p.name, price: p.price.toString(), total: 2.toString(), image: p.image,);
                      },
                    ),
                  ),
                  CartBottom(onPressed: (){
                    _goToConfirmButton(context);
                  },total: "30", price: "20.000.000",
                  marginBottom: 0,)
                ],
              )
            ));
        }
    );
  }
}
