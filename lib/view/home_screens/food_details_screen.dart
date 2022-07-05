import 'package:fastfood_app/model/restaurant_model/addon_model.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/model/restaurant_model/size_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/food_widget/food_details_Image_widget.dart';
import 'package:fastfood_app/widget/food_widget/food_details_addon_widget.dart';
import 'package:fastfood_app/widget/food_widget/food_details_description_widget.dart';
import 'package:fastfood_app/widget/food_widget/food_details_name_widget.dart';
import 'package:fastfood_app/widget/food_widget/food_details_size_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  static const routeName = 'FoodDetailsScreen';
  FoodModel? foodModel;

  FoodDetailsScreen({this.foodModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int? quantity = 1;
  double? totalPrice;
  SizeModel selectedSize = SizeModel(name: 'name', price: 0);
  List<AddonModel> selectedAddon = List<AddonModel>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    widget.foodModel = ModalRoute.of(context)!.settings.arguments as FoodModel;
    totalPrice = widget.foodModel!.price * quantity!;
    return Consumer2<CartProvider, RestaurantProvider>(
      builder: (context, provider, resProvider, x) {
        return Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: CustomText(
                  text: '${widget.foodModel!.name}',
                  colorText: Colors.black,
                ),
                automaticallyImplyLeading: false,
                leadingWidth: 50.w,
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      provider.getQuantity(
                          resProvider.selectedRestaurant!.restaurantId!);
                    });
                    RouteHelper.routeHelper.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                ),
                elevation: 10,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize:
                      Size.square(MediaQuery.of(context).size.height / 3),
                  child: FoodDetailImageWidget(
                    onPressedCart: () {
                      setState(() {
                        provider.addToCart(
                          widget.foodModel!,
                          resProvider.selectedRestaurant!.restaurantId!,
                          quantity: quantity!,
                        );
                      });
                    },
                    foodModel: widget.foodModel,
                    tagHero: widget.foodModel!.name,
                    image: widget.foodModel!.image,
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FoodDetailsNameWidget(
                    quantity: quantity!,
                    name: widget.foodModel!.name,
                    price: totalPrice!,
                    onChanged: (num) {
                      setState(() {
                        quantity = num.toInt();
                      });
                    },
                  ),
                  FoodDetailsDescriptionWidget(
                    description: widget.foodModel!.description,
                  ),
                  widget.foodModel!.size.length > 0
                      ? FoodDetailsSizeWidget(
                          children: widget.foodModel!.size,
                          selectedSize: selectedSize,
                        )
                      : Container(),
                  FoodDetailsAddonWidget(
                      foodModel: widget.foodModel!,
                      selectedAddon: selectedAddon),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
