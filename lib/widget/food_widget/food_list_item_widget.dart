import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/home_screens/food_details_screen.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FoodListItemWidget extends StatefulWidget {
  FoodModel foodModel;
  Function onTapCart;
  Function onTapFav;

  FoodListItemWidget(
      {required this.foodModel,
      required this.onTapCart,
      required this.onTapFav});

  @override
  _FoodListItemWidgetState createState() => _FoodListItemWidgetState();
}

class _FoodListItemWidgetState extends State<FoodListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouteHelper.routeHelper
            .goToPage(FoodDetailsScreen.routeName, object: widget.foodModel);
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Hero(
            tag: widget.foodModel.name,
            child: SizedBox(
              height: 320.h,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.foodModel.image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Icon(Icons.image),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onTapFav();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0.h),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: CircleAvatar(
                            backgroundColor: ColorConst.primaryColor,
                            radius: 20.r,
                            child: CircleAvatar(
                              backgroundColor: ColorConst.primaryColor,
                              radius: 17.r,
                              child:
                                  SvgPicture.asset('assets/icons/love_b.svg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 68.5.h,
                        color: ColorConst.primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 130.w,
                                  child: CustomText(
                                    text: widget.foodModel.name,
                                    colorText: Colors.white,
                                    fontSize: 12.sp,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                CustomText(
                                  text: '\$${widget.foodModel.price}',
                                  colorText: ColorConst.colorText,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onTapCart();
            },
            child: Transform.translate(
              offset: Offset(0, 15.h),
              child: CircleAvatar(
                backgroundColor: ColorConst.primaryColor,
                radius: 20.r,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17.r,
                  child: SvgPicture.asset('assets/icons/cart.svg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
