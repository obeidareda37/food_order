import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/helpers/auth_helpers.dart';
import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/order_history_widget/order_history_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget(
      {Key? key, required this.orderStatusMode, required this.listOrder})
      : super(key: key);

  final String orderStatusMode;
  final List<OrderModel> listOrder;

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getUserOrdersByRestaurant(
        Provider.of<RestaurantProvider>(context, listen: false)
            .selectedRestaurant!
            .restaurantId!,
        AuthHelpers.authHelpers.getUserId(),
        widget.orderStatusMode);
  }

  @override
  Widget build(BuildContext context) {

    if (widget.listOrder.length == 0)
      return Center(
        child: CustomText(
          text: emptyText,
        ),
      );
    else {
      return OrderHistoryListWidget(listOrder: widget.listOrder);
    }
  }
}
