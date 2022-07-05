import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/order_history_widget/order_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const routeName = 'OrderHistoryScreen';

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.cancel,
                    color: ColorConst.primaryColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.refresh,
                    color: ColorConst.primaryColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.check,
                    color: ColorConst.primaryColor,
                  ),
                ),
              ],
            ),
            title: CustomText(
              text: 'Order History',
              colorText: ColorConst.colorText,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                RouteHelper.routeHelper.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: ColorConst.primaryColor,
              ),
            ),
            leadingWidth: 40.w,
          ),
          body: Consumer<CartProvider>(builder: (context, cartProvider, x) {
            return TabBarView(
              children: [
                OrderHistoryWidget(
                    orderStatusMode: ORDER_CANCELLED,
                    listOrder: cartProvider.orderHistory),
                OrderHistoryWidget(
                    orderStatusMode: ORDER_PROCESSING,
                    listOrder: cartProvider.orderHistory),
                OrderHistoryWidget(
                    orderStatusMode: ORDER_SHIPPED,
                    listOrder: cartProvider.orderHistory),
              ],
            );
          }),
          // body: Consumer<CartProvider>(builder: (context, cartProvider, x) {
          //   return OrderHistoryWidget(
          //     listOrder: cartProvider.orderHistory,
          //   );
          // }),
        ),
      ),
    );
  }
}
