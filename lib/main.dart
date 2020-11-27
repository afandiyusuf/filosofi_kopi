import 'package:filkop_mobile_apps/bloc/adress/address_bloc.dart';
import 'package:filkop_mobile_apps/bloc/apparel/apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart/cart_product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/cart_apparel/cart_apparel_bloc.dart';
import 'package:filkop_mobile_apps/bloc/city/city_bloc.dart';
import 'package:filkop_mobile_apps/bloc/gosend/gosend_bloc.dart';
import 'package:filkop_mobile_apps/bloc/order_box/order_box_bloc.dart';
import 'package:filkop_mobile_apps/bloc/product/product_bloc.dart';
import 'package:filkop_mobile_apps/bloc/province/province_bloc.dart';
import 'package:filkop_mobile_apps/bloc/sub_district/sub_district_bloc.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_bloc.dart';
import 'package:filkop_mobile_apps/bloc/transaction/transaction_state.dart';
import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/repository/apparel_repository.dart';
import 'package:filkop_mobile_apps/repository/cart_apparel_repository.dart';
import 'package:filkop_mobile_apps/repository/cart_repository.dart';
import 'package:filkop_mobile_apps/repository/product_repository.dart';
import 'package:filkop_mobile_apps/repository/rajaongkir_repository.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/service/rajaongkir_service.dart';
import 'package:filkop_mobile_apps/view/screen/address_screen.dart';
import 'package:filkop_mobile_apps/view/screen/before_login_screen.dart';
import 'package:filkop_mobile_apps/view/screen/confirm_order.dart';
import 'package:filkop_mobile_apps/view/screen/create_account_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_apparel_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_product_screen.dart';
import 'package:filkop_mobile_apps/view/screen/detail_transaction.dart';
import 'package:filkop_mobile_apps/view/screen/login_screen.dart';
import 'package:filkop_mobile_apps/view/screen/on_boarding_screen.dart';
import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:filkop_mobile_apps/view/screen/referral_code_screen.dart';
import 'package:filkop_mobile_apps/view/screen/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:filkop_mobile_apps/view/screen/signin_screen.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MainApp());
}
class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final rootRoute = '/';
  final rootScreen = OnBoardingScreen();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderBoxBloc>(
          create: (_) => OrderBoxBloc(),
        ),
        BlocProvider<CartProductBloc>(
          create: (_) => CartProductBloc(cartRepository: CartRepository(apiService: ApiService())),
        ),
        BlocProvider<CartApparelBloc>(
          create: (_) => CartApparelBloc(cartRepository: CartApparelRepository(apiService: ApiService())),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
              repository: ProductRepository(apiService: ApiService())),
        ),
        BlocProvider<ApparelBloc>(
          create: (_) => ApparelBloc(
              repository: ApparelRepository(apiService: ApiService())),
        ),
        BlocProvider<AddressBloc>(
          create: (_)=>AddressBloc(
            addressModel: UserAddressModel()
          ),
        ),
        BlocProvider<ProvinceBloc>(
          create: (_) => ProvinceBloc(
              rajaOngkirRepository:
              RajaOngkirRepository(rajaOngkirService: RajaOngkirService())),
        ),
        BlocProvider<CityBloc>(
          create: (_) => CityBloc(
            rajaOngkirRepository:
            RajaOngkirRepository(rajaOngkirService: RajaOngkirService()),
          ),
        ),
        BlocProvider<SubDistrictBloc>(
          create: (_) => SubDistrictBloc(
            rajaOngkirRepository:
            RajaOngkirRepository(rajaOngkirService: RajaOngkirService()),
          ),
        ),
        BlocProvider<GosendBloc>(
          create: (_) => GosendBloc(
            cartRepository: CartRepository(apiService: ApiService())
          ),
        ),
        BlocProvider<TransactionBloc>(
          create: (_) => TransactionBloc(TransactionInit()),
        )
      ],
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: BeforeLoginScreen.tag,
          routes: {
            BeforeLoginScreen.tag : (context) => BeforeLoginScreen(),
            OnBoardingScreen.tag : (context) => OnBoardingScreen(),
            AddressPage.tag : (context) => AddressPage(),
            SignInScreen.tag : (context) => SignInScreen(),
            MainScreen.tag : (context) => MainScreen(),
            CreateAccountScreen.tag : (context) => CreateAccountScreen(),
            VerifyPhoneScreen.tag : (context) => VerifyPhoneScreen(),
            LoginScreen.tag : (context) => LoginScreen(),
            PickOurStoresScreen.tag : (context) => PickOurStoresScreen(),
            DetailProductScreen.tag : (context) => DetailProductScreen(),
            DetailApparelScreen.tag : (context) => DetailApparelScreen(),
            ConfirmOrder.tag : (context) => ConfirmOrder(),
            ReferralCodeScreen.tag : (context) => ReferralCodeScreen(),
            DetailTransaction.tag : (context) => DetailTransaction()
          },
        ),
      ),
    );
  }
}



