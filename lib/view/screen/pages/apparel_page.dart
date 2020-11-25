import 'package:filkop_mobile_apps/bloc/apparel/apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/apparel/apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/apparel/apparel_state.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_event.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_state.dart';
import 'package:filkop_mobile_apps/bloc/category_apparel/category_apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/category_apparel/category_apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/category_apparel/category_apparel_state.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:filkop_mobile_apps/model/category_apparel_model.dart';
import 'package:filkop_mobile_apps/model/order_box_model.dart';
import 'package:filkop_mobile_apps/repository/category_apparel_repository.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/category_button.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:filkop_mobile_apps/view/component/rupiah.dart';
import 'package:filkop_mobile_apps/view/screen/detail_apparel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApparelPage extends StatefulWidget {
  final OrderBoxBloc orderBoxBloc;

  const ApparelPage({Key key, this.orderBoxBloc}) : super(key: key);

  @override
  _ApparelPageState createState() => _ApparelPageState();
}

class _ApparelPageState extends State<ApparelPage> {
  CategoryApparelModel categoryApparelModel;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  ApparelModel apparels;

  @override
  void initState() {
    //fetch orderaox
    FetchCart();
    super.initState();
  }

  void fetchCartInit() async {
//    var _pref = await pref;
//    var location = _pref.getString('location');
//    if(location != null) {
//      context.bloc<CartBloc>().add(FetchCart(location: location));
//    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 1.4;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CategoryApparelBloc(
                repository:
                    CategoryApparelRepository(apiService: ApiService())))
      ],
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
          child: Column(
            children: <Widget>[
              BlocBuilder<CategoryApparelBloc, CategoryApparelState>(
                  builder: (context, state) {
                if (state is CategoryApparelEmpty) {
                  context
                      .bloc<CategoryApparelBloc>()
                      .add(FetchCategoryApparel());
                }
                if (state is CategoryApparelUpdating) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CategoryApparelUpdated) {
                  categoryApparelModel = state.categoryApparelModel;
                  return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryApparelModel.count(),
                        itemBuilder: (BuildContext context, int index) {
                          CategoryApparel category =
                              categoryApparelModel.getByIndex(index);
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
              BlocBuilder<ApparelBloc, ApparelState>(
                  builder: (context, apparelState) {
                if (apparelState is ApparelEmpty) {
                  OrderBoxModel orderBox =
                      context.bloc<OrderBoxBloc>().orderBox;
                  context
                      .bloc<ApparelBloc>()
                      .add(FetchApparel(store: orderBox.location));
                }
                if (apparelState is ApparelDataLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (apparelState is ApparelDataLoaded) {
                  apparels = apparelState.apparels;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: (itemWidth / itemHeight),
                          children: List.generate(apparels.getTotal(), (index) {
                            Apparel _apparel = apparels.getByIndex(index);
                            String priceFormatted =
                                rupiah(double.parse(_apparel.price));
//                            return BlocBuilder<CartBloc, CartState>(
//                                builder: (context, state) {
                            int total = 0;
//                                  if(state is CartUpdated){
//                                    CartModel cartModel = state.cartModel;
//                                    total = cartModel.getTotalItemsByIndex(_product.id);
//                                  }
                            return ProductCard(
                              id: int.parse(_apparel.id),
                              name: _apparel.name,
                              price: priceFormatted,
                              category: _apparel.catId[0].categoryId,
                              image:
                                  "${_apparel.image[0].linkImage}${_apparel.image[0].name}",
                              total: total,
                              onTap: () {
                                _goToDetail(_apparel, context);
                              },
                            );
                            //  }
                            // );
                          })),
                    ),
                  );
                }

                if (apparelState is ApparelDataError) {
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

  _goToDetail(Apparel product, BuildContext context) {
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
        .add(OrderBoxSelectApparel(selectedApparel: product, total: total));
    Navigator.pushNamed(context, DetailApparelScreen.tag);
  }

  _selectCategory(String categoryName, BuildContext context) {
    context
        .bloc<CategoryApparelBloc>()
        .add(SelectCategoryApparel(categoryName));
    context
        .bloc<ApparelBloc>()
        .add(SetApparelByCategory(categoryName: categoryName));
  }
}
