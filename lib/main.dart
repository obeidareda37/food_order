import 'package:easy_localization/easy_localization.dart';
import 'package:fastfood_app/provider/auth_provider.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/auth_screen/forget_password.dart';
import 'package:fastfood_app/view/auth_screen/login_screen.dart';
import 'package:fastfood_app/view/auth_screen/register_screen.dart';
import 'package:fastfood_app/view/cart_screen/cart_screen.dart';
import 'package:fastfood_app/view/drawer/menu_drawer.dart';
import 'package:fastfood_app/view/home_screens/category_screen.dart';
import 'package:fastfood_app/view/home_screens/food_details_screen.dart';
import 'package:fastfood_app/view/home_screens/food_list_screen.dart';
import 'package:fastfood_app/view/home_screens/home_restaurant_page.dart';
import 'package:fastfood_app/view/home_screens/home_screen.dart';
import 'package:fastfood_app/view/order_screens/order_history_details_screen.dart';
import 'package:fastfood_app/view/order_screens/order_history_screen.dart';
import 'package:fastfood_app/view/order_screens/place_order_screen.dart';
import 'package:fastfood_app/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/langs',
      fallbackLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => RestaurantProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Food Order',
          navigatorKey: RouteHelper.routeHelper.navKey,
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ForgetPassword.routeName: (context) => ForgetPassword(),
            SplashScreen.routeName: (context) => SplashScreen(),
            HomeRestaurantPage.routeName: (context) => HomeRestaurantPage(),
            DrawerMenu.routeName: (context) => DrawerMenu(),
            CategoryScreen.routeName: (context) => CategoryScreen(),
            FoodListScreen.routeName: (context) => FoodListScreen(),
            FoodDetailsScreen.routeName: (context) => FoodDetailsScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            PlaceOrderScreen.routeName: (context) => PlaceOrderScreen(),
            OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
            OrderHistoryDetailsScreen.routeName: (context) => OrderHistoryDetailsScreen(),
          },
          home: App(),
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreen();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
        // // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
      },
    );
  }
}
