import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/cart_consts.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/cart_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/drawer/drawer_zoom_screen.dart';
import 'package:fastfood_app/view/drawer/menu_drawer.dart';
import 'package:fastfood_app/view/home_screens/home_restaurant_page.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class HomeScreen extends StatefulWidget {
  static final routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).getRestaurantList();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (box.hasData(MY_CART_KEY)) {
        var cartSave = await box.read(MY_CART_KEY) as String;
        if (cartSave.length > 0 && cartSave.isNotEmpty) {
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParsed =
              listCart.map((e) => CartModel.fromJson(e)).toList();
          if (listCartParsed.length > 0) {
            Provider.of<CartProvider>(context, listen: false).cart =
                listCartParsed;
          }
        }
      } else {
        Provider.of<CartProvider>(context, listen: false).cart =
            List<CartModel>.empty(growable: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: CustomText(
            text: easy.tr('homeScreenTitleAppBar'),
            colorText: ColorConst.colorText,
          ),
          elevation: 2,
          backgroundColor: Colors.white,
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, provider, x) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.selectedRestaurant =
                                    provider.restaurantList[index];
                                RouteHelper.routeHelper
                                    .goToPage(HomeRestaurantPage.routeName);
                              },
                              child: Container(
                                height: 250.h,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(Icons.image),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    imageUrl: provider
                                        .restaurantList[index].imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    RichText(
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: provider
                                                  .restaurantList[index].name!
                                                  .substring(0, 11 - 1)),
                                          new TextSpan(
                                              text:
                                                  ' ${provider.restaurantList[index].name!}'
                                                      .substring(11),
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorConst.colorText)),
                                        ],
                                      ),
                                    ),
                                    // CustomText(
                                    //   text:
                                    //       provider.restaurantList[index].name!,
                                    //   fontWeight: FontWeight.w900,
                                    // ),
                                    CustomText(
                                      text: provider
                                          .restaurantList[index].address!,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: provider.restaurantList.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
