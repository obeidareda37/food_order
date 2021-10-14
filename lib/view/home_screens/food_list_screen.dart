import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/category_model.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/home_screens/food_details_screen.dart';
import 'package:fastfood_app/widget/custom_app_bar/app_bar_cart_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/food_widget/food_list_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatefulWidget {
  static const routeName = 'FoodListScreen';
  CategoryModel? categoryModel;

  FoodListScreen({this.categoryModel});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<FoodModel>? foodModel;

  @override
  Widget build(BuildContext context) {
    widget.categoryModel =
        ModalRoute.of(context)!.settings.arguments! as CategoryModel;
    foodModel = widget.categoryModel!.foods;
    return Scaffold(
      appBar: AppBarWithCartButton(
        title: widget.categoryModel!.name,
      ),
      body: Consumer2<CartProvider, RestaurantProvider>(
          builder: (context, provider, resProvider, x) {
        return Column(children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.w,
                  mainAxisSpacing: 20.h),
              itemBuilder: (context, index) {
                return FoodListItemWidget(
                    foodModel: foodModel![index],
                    onTapCart: () {
                      setState(() {
                        provider.addToCart(foodModel![index],
                            resProvider.selectedRestaurant!.restaurantId!);
                      });
                    },
                    onTapFav: () {});
              },
              itemCount: foodModel!.length,
            ),
          )
        ]);
      }),
    );
  }
}
