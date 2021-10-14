import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FoodDetailImageWidget extends StatefulWidget {
  late String image;
  String? tagHero;
  FoodModel? foodModel;
  Function? onPressedCart;

  FoodDetailImageWidget(
      {required this.image, this.tagHero, this.foodModel, this.onPressedCart});

  @override
  State<FoodDetailImageWidget> createState() => _FoodDetailImageWidgetState();
}

class _FoodDetailImageWidgetState extends State<FoodDetailImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, x) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height / 3) * 0.9,
              child: Hero(
                tag: widget.tagHero!,
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Icon(Icons.image),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.8.w, 1.0.h),
              heightFactor: 0.5.h,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: ColorConst.primaryColor,
                        radius: 20.r,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 17.r,
                          child: SvgPicture.asset('assets/icons/love_b.svg'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onPressedCart!();
                      },
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
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
