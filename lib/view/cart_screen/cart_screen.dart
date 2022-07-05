import 'package:fastfood_app/const/cart_consts.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/custom_dialog.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/order_screens/place_order_screen.dart';
import 'package:fastfood_app/widget/cart_widget/cart_image_widget.dart';
import 'package:fastfood_app/widget/cart_widget/cart_info.dart';
import 'package:fastfood_app/widget/cart_widget/cart_total_widget.dart';
import 'package:fastfood_app/widget/custom_button/custom_button_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, RestaurantProvider>(
      builder: (context, provider, resProvider, x) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white),
            backgroundColor: Colors.white,
            title: CustomText(
              text: 'Cart',
              colorText: ColorConst.primaryColor,
            ),
            leading: IconButton(
              onPressed: () {
                RouteHelper.routeHelper.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: ColorConst.primaryColor,
              ),
            ),
            leadingWidth: 50.w,
            actions: [
              provider.getQuantity(
                          resProvider.selectedRestaurant!.restaurantId!) >
                      0
                  ? IconButton(
                      onPressed: () {
                        CustomDialog.customDialog.showCustomDialog(
                            title: CLEAR_CART_TITLE,
                            message: CLEAR_CART_CONTENT,
                            function: () {
                              setState(() {});
                              provider.clearCart(resProvider
                                  .selectedRestaurant!.restaurantId!);
                            });
                      },
                      icon: Icon(Icons.clear),
                    )
                  : Container(),
            ],
          ),
          body: provider.getQuantity(
                      resProvider.selectedRestaurant!.restaurantId!) >
                  0
              ? Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Slidable(
                          child: Card(
                            elevation: 8.0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0.w, vertical: 6.0.h),
                            child: Container(
                              padding: EdgeInsets.all(15.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CartImageWidget(
                                      cartModel: provider.cart[index],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: CartInfo(
                                      cartModel: provider.cart[index],
                                    ),
                                  ),
                                  Center(
                                    child: ElegantNumberButton(
                                        initialValue:
                                            provider.cart[index].quantity,
                                        minValue: 1,
                                        maxValue: 100,
                                        color: ColorConst.colorText,
                                        onChanged: (value) {
                                          setState(() {
                                            provider.cart[index].quantity =
                                                value.toInt();
                                            provider.saveDatabase();
                                          });
                                        },
                                        decimalPlaces: 0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: [
                            IconSlideAction(
                              caption: DELETE_TEXT,
                              icon: Icons.delete,
                              color: Colors.red,
                              onTap: () {
                                CustomDialog.customDialog.showCustomDialog(
                                    message: DELETE_CART_CONTENT,
                                    title: DELETE_CART_TITLE,
                                    function: () {
                                      setState(() {});
                                      provider.cart.removeAt(index);
                                      provider.saveDatabase();
                                    });
                              },
                            ),
                          ],
                        );
                      },
                      itemCount: provider.cart.length,
                    )),
                    TotalWidget(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                      width: double.infinity,
                      height: 50.h,
                      child: CustomButtonWidget(
                        onPressed: () {
                          // provider.getCart(
                          //     resProvider.selectedRestaurant!.restaurantId!),
                          RouteHelper.routeHelper
                              .goToPage(PlaceOrderScreen.routeName);
                        },
                        text: 'Checkout',
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CustomText(
                    text: CART_EMPTY,
                    colorText: ColorConst.primaryColor,
                  ),
                ),
        );
      },
    );
  }
}
