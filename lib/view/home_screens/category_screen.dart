import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/home_screens/food_list_screen.dart';
import 'package:fastfood_app/widget/custom_app_bar/app_bar_cart_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'CategoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false)
        .getCategoryByRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, x) {
        return Scaffold(
            appBar: AppBarWithCartButton(
              systemUiOverlayStyle:  SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white),
              title: '${provider.selectedRestaurant!.name}',
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: provider.categoryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.w,
                          mainAxisSpacing: 1.h),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            RouteHelper.routeHelper.goToPage(
                                FoodListScreen.routeName,
                                object: provider.categoryList[index]);
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: provider.categoryList[index].image,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, err) => Center(
                                    child: Icon(Icons.image),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                Container(
                                  color: ColorConst.colorOverly,
                                ),
                                Center(
                                  child: CustomText(
                                    text: provider.categoryList[index].name,
                                    colorText: Colors.white,
                                    fontSize: 20.sp,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
