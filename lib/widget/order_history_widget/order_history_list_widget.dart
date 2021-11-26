import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/utils/utils.dart';
import 'package:fastfood_app/view/order_screens/order_history_details_screen.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryListWidget extends StatelessWidget {
  const OrderHistoryListWidget({Key? key, required this.listOrder})
      : super(key: key);
  final List<OrderModel> listOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                RouteHelper.routeHelper.goToPage(
                    OrderHistoryDetailsScreen.routeName,
                    object: listOrder[index]);
              },
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: listOrder[index].cartItemList![0].image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.image),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: ColorConst.colorOverly,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 20.0.h, bottom: 20.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        text:
                                            'Order #${listOrder[index].orderNumber}',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w900,
                                        colorText: Colors.white,
                                      ),
                                      CustomText(
                                        text:
                                            'Date ${convertToDate(listOrder[index].createdDate!)}',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w900,
                                        colorText: Colors.white,
                                      ),
                                      CustomText(
                                        text:
                                            'Order Status: ${convertStatus(listOrder[index].orderStatus!)}',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w900,
                                        colorText: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: listOrder.length,
        )),
      ],
    );
  }
}
