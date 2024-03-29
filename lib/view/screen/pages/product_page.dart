import 'package:filkop_mobile_apps/bloc/cart/cart_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_state.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_event.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/product/product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/product/product_event.dart';
import 'package:filkop_mobile_apps/bloc/product/product_state.dart';
import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/repository/category_product_repository.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/category_button.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/screen/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  final OrderBoxBloc orderBoxBloc;
  ProductPage({this.orderBoxBloc});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CategoryProductModel categoryProductModel;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  ProductModel products;

  @override
  void initState() {
    //fetch orderaox
    fetchCartInit();
    super.initState();
  }

  void fetchCartInit() async{
    var _pref = await pref;
    var location = _pref.getString('location');
    if(location != null) {
      context.bloc<CartProductBloc>().add(FetchCart(location: location));
    }
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 1.4;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CategoryProductBloc(
                repository:
                    CategoryProductRepository(apiService: ApiService())))
      ],
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
          child: Column(
            children: <Widget>[
              BlocBuilder<CategoryProductBloc, CategoryProductState>(
                  builder: (context, state) {
                if (state is CategoryProductEmpty) {
                  context
                      .bloc<CategoryProductBloc>()
                      .add(FetchCategoryProduct());
                }
                if(state is CategoryProductUpdating){
                  return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 0),
                        height: 30,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15, left: 15),
                                    child: Center(child:Container(width: 40,)),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                  )
                              );
                            }),
                      ));
                }

                if (state is CategoryProductUpdated) {
                  categoryProductModel = state.categoryProductModel;
                  return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProductModel.count(),
                        itemBuilder: (BuildContext context, int index) {
                          CategoryProduct category =
                              categoryProductModel.getByIndex(index);
                          return CategoryButton(
                            name: category.name,
                            selected: category.selected,
                            onTap: () {
                              _selectCategory(category.name, context);
                            },
                          );
                        }),
                  );
                }
                return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    height: 30,);
              }),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, productState) {
                print("PRODUCT STATE IS $productState");
                if (productState is ProductEmpty) {
                  print("EMPTY");
                  OrderBoxModel orderBox =
                      context.bloc<OrderBoxBloc>().orderBox;
                  context
                      .bloc<ProductBloc>()
                      .add(FetchProduct(store: orderBox.location));
                }
                if(productState is ProductDataLoading){
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (productState is ProductDataLoaded) {
                  products = productState.products;
                  print("products is $products");
                  if(context.bloc<CartProductBloc>().state is CartInitState){
                    OrderBoxModel orderBox =
                        context.bloc<OrderBoxBloc>().orderBox;
                    context.bloc<CartProductBloc>().add(FetchCart(location: orderBox.location));
                  }
                  if(context.bloc<CartProductBloc>().state is CartUpdated){
                    CartUpdated state = context.bloc<CartProductBloc>().state;
                    CartProductModel cm = state.cartModel;

                    products.sortByBought(cm);
                  }else{
                    print("not sort");
                  }

                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0).copyWith(bottom: 60),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: (itemWidth / itemHeight),
                          children: List.generate(products.getTotal(), (index) {
                            Product _product = products.getByIndex(index);
                            String priceFormatted = rupiah(double.parse(_product.price));
                            return BlocBuilder<CartProductBloc, CartProductState>(
                              builder: (context, state) {
                                int total = 0;
                                if(state is CartUpdated){
                                  CartProductModel cartModel = state.cartModel;
                                  total = cartModel.getTotalItemsByIndex(_product.id);
                                }
                                return ProductCard(
                                  id: int.parse(_product.id),
                                  name: _product.name,
                                  price: priceFormatted,
                                  category: _product.category,
                                  image: _product.image,
                                  total: total,
                                  onTap: () {
                                    _goToDetail(_product, context);
                                  },
                                );
                              }
                            );
                          })),
                    ),
                  );
                }

                if (productState is ProductDataError) {
                  return Center(
                    child: Text("Error"),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  _goToDetail(Product product, BuildContext context) {
    int total = 0;
    if (context.bloc<CartProductBloc>().state is CartUpdated) {
      print("result is");
      print(context.bloc<CartProductBloc>().state is CartUpdated);
      CartUpdated state = context.bloc<CartProductBloc>().state;
      if (state.cartModel != null) {
        //get total menu
        total = state.cartModel.getTotalItemsByIndex(product.id);
      }
    }
    print("total is $total");
    context
        .bloc<OrderBoxBloc>()
        .add(OrderBoxSelectProduct(selectedProduct: product, total: total));
    Navigator.pushNamed(context, DetailProductScreen.tag);
  }

  _selectCategory(String categoryName, BuildContext context) {
    context
        .bloc<CategoryProductBloc>()
        .add(SelectCategoryProduct(categoryName));
    context
        .bloc<ProductBloc>()
        .add(SetProductsByCategory(categoryName: categoryName));
  }
}
