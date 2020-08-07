import 'package:filkop_mobile_apps/bloc/cart/cart_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_state.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_event.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/product/product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/product/product_event.dart';
import 'package:filkop_mobile_apps/bloc/product/product_state.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/repository/category_product_repository.dart';
import 'package:filkop_mobile_apps/repository/product_repository.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/category_button.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Menu extends StatefulWidget {
  final OrderBoxBloc orderBoxBloc;

  Menu({this.orderBoxBloc});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  CategoryProductModel categoryProductModel;
  ProductModel products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 1.4;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
              repository: ProductRepository(apiService: ApiService())),
        ),
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
                if (state is CategoryProductUpdated) {
                  categoryProductModel = state.categoryProductModel;

                  return Container(
                    margin: EdgeInsets.only(top: 50, bottom: 0),
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
                return Container();
              }),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is ProductEmpty) {
                  OrderBoxModel orderBox =
                      context.bloc<OrderBoxBloc>().orderBox;
                  context
                      .bloc<ProductBloc>()
                      .add(FetchProduct(store: orderBox.location));
                }
                if(state is ProductDataLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductDataLoaded) {
                  products = state.products;

                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: GridView.count(
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: (itemWidth / itemHeight),
                          children: List.generate(products.getTotal(), (index) {
                            Product _product = products.getByIndex(index);

                            FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                                amount: double.parse(_product.price));
                            String priceFormatted = fmf
                                .copyWith(
                                    symbol: 'Rp.',
                                    symbolAndNumberSeparator: ' ')
                                .output
                                .symbolOnLeft;

                            return ProductCard(
                              id: int.parse(_product.id),
                              name: _product.name,
                              price: priceFormatted,
                              category: _product.category,
                              image: _product.image,
                              onTap: () {
                                _goToDetail(_product, context);
                              },
                            );
                          })),
                    ),
                  );
                }

                if (state is ProductDataError) {
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
    if (context.bloc<CartBloc>().state is CartUpdated) {
      print(context.bloc<CartBloc>().state);
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

  _selectCategory(String categoryName, BuildContext context) {
    context
        .bloc<CategoryProductBloc>()
        .add(SelectCategoryProduct(categoryName));
    context
        .bloc<ProductBloc>()
        .add(SetProductsByCategory(categoryName: categoryName));
  }
}
