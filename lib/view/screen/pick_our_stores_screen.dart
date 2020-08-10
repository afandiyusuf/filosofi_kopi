import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_event.dart';
import 'package:filkop_mobile_apps/bloc/store_data//store_data_event.dart';
import 'package:filkop_mobile_apps/bloc/store_data/store_data_bloc.dart';
import 'package:filkop_mobile_apps/bloc/store_data/store_data_state.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:filkop_mobile_apps/repository/store_data_repository.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickOurStoresScreen extends StatelessWidget {
  static final String tag = '/pick-our-stores';
  final StoreDataRepository repository = StoreDataRepository(apiService: ApiService());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = 180;
    final double itemWidth = size.width / 1.8;

    return BlocProvider(
        create: (context) => StoreDataBloc(repository: repository),
        child: BlocBuilder<StoreDataBloc, StoreDataState>(
            builder: (context, state) {

              if (state is StoreDataEmpty) {
                BlocProvider.of<StoreDataBloc>(context).add(FetchStoreData());
              }
              if (state is StoreDataError) {
                return Text("Error");
              }

              if (state is StoreDataLoaded) {
                return Scaffold(
                  appBar: CustomAppBar(titleText: "Pick Our Stores"),
                  body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            childAspectRatio: (itemWidth / itemHeight),
                            children: List.generate(
                                state.storeDatas.getTotalStore(), (index) {
                              Store store = state.storeDatas.getStoreByIndex(
                                  index);
                              return InkWell(
                                onTap: () {
                                  setStore(context, store.location,store.id);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                6),
                                            child: Image.network(
                                              store.image,
                                              fit: BoxFit.contain,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6)),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          store.location.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })),
                      )),
                );
              }
              return Scaffold(
                  appBar: CustomAppBar(titleText: "Pick Our Stores"),
                  body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          child: Center(child: CircularProgressIndicator()))));
            }));
  }

  Future<void> setStore(BuildContext context, String location, int storeId) async {
    context.bloc<OrderBoxBloc>().add(OrderBoxUpdateLocation(location: location, storeId: storeId));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    Navigator.pop(context);
  }
}
