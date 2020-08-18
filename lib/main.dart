import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/models/user_stream.dart';
import 'package:e_commerce/provider/cart_items.dart';
import 'package:e_commerce/screens/cart/car_order.dart';
import 'package:e_commerce/screens/home/homepage.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/screens/payment/buy_now.dart';
import 'package:e_commerce/screens/payment/existing_cards.dart';
import 'package:e_commerce/screens/singup/singup.dart';
import 'package:e_commerce/services/locator.dart';
import 'package:e_commerce/services/user_db.dart';
import 'package:e_commerce/shared/chech_first_time.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'screens/admin_side/add_new_product.dart';
import 'screens/all_categoris/accesories.dart';
import 'screens/all_categoris/books.dart';
import 'screens/all_categoris/clothes.dart';
import 'screens/all_categoris/electronics.dart';
import 'screens/all_categoris/makeup.dart';
import 'screens/all_categoris/mobile.dart';
import 'screens/all_categoris/shoes.dart';
import 'screens/all_categoris/sports.dart';
import 'screens/all_products/main_all_products.dart';
import 'screens/check_goto_home_or_auth/check.dart';
import 'screens/drawer_contant/Categorise.dart';
import 'screens/drawer_contant/about.dart';
import 'screens/drawer_contant/favourites/favourites_orders.dart';
import 'screens/drawer_contant/my_account/my_account.dart';
import 'screens/drawer_contant/setting.dart';
import 'screens/onborading/intro_screen.dart';
import 'services/auth_firebase.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Color(0xFF00beff),
  systemNavigationBarColor: Colors.white

));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( 
          create: (context) => locator<CRUDModel>()
          ),
           ChangeNotifierProvider<CartItem>( 
          create: (context) => CartItem()
          ),
       StreamProvider<User>.value(
         value: Services().user,
        ),
        StreamProvider<UserStream>.value(
        catchError: (_, __) => null,
         value: DataBaseServices().user,
        ),
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        title: 'E Commerce',
        home: Start(),
        routes: {
          "/HomePage":(context) => HomePage(),
          "/CartdOrder":(context)=>CartdOrder(),
          "/login":(context)=>LoginScreen(),
          "/Singup":(context) =>SingUPScreen(),
          "ProfilePage":(context) =>ProfilePage(),
          "/payment":(context) =>BuyNowPayment(),
          "/existing-cards":(context) =>ExistingCardsPage(),
          "/about":(context) =>About(),
          "/Settings":(context) =>Settings(),
          "/Categoris":(context) =>Categoris(),
          "/MainAllProducts":(context) =>MainAllProducts(),
          "/AddNewProdcts":(context) =>AddNewProdcts(),
          "/SportsCategory":(context) =>SportsCategory(),
          "/ShoseCategory":(context) =>ShoseCategory(),
          "/AccesoriesCategory":(context) =>AccesoriesCategory(),
          "/BooksCategory":(context) =>BooksCategory(),
          "/ClothesCategory":(context) =>ClothesCategory(),
          "/ElectronicsCategory":(context) =>ElectronicsCategory(),
          "/MakeupCategory":(context) =>MakeupCategory(),
          "/MobileCategory":(context) =>MobileCategory(),
          "/FavouritesOrders":(context) =>FavouritesOrders(),
          "/Check":(context) =>Check(),
          "/IntroScreen":(context) =>IntroScreen(),
        },

        ),
    );
  }
}
