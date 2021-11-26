import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryDetailsScreen extends StatelessWidget {
  static const routeName = 'OrderHistoryDetailsScreen';

  OrderHistoryDetailsScreen({Key? key, this.orderModel}) : super(key: key);
  OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    orderModel = ModalRoute.of(context)!.settings.arguments as OrderModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'Order ${orderModel!.orderNumber}',
          ),
          actions: [
            (orderModel!.orderStatus == 0 || orderModel!.orderStatus == 1)
                ? InkWell(
                    child: Icon(Icons.clear),
                    onTap: () {},
                  )
                : Container()
          ],
        ),
        body: Center(
          child: CustomText(
            text: 'Order Details',
          ),
        ),
      ),
    );
  }
}
