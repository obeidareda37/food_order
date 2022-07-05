import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/view/drawer/menu_drawer.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeRestaurantPage extends StatefulWidget {
  static final routeName = 'HomeRestaurantPage';
  final ZoomDrawerController? zoomDrawerController;

  HomeRestaurantPage({this.zoomDrawerController});

  @override
  State<HomeRestaurantPage> createState() => _HomeRestaurantPageState();
}

class _HomeRestaurantPageState extends State<HomeRestaurantPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false)
        .getMostPopularItemRestaurant();
    Provider.of<RestaurantProvider>(context, listen: false)
        .getBestDealsItemRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        title: RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: new TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              new TextSpan(
                  text: Provider.of<RestaurantProvider>(context)
                      .selectedRestaurant!
                      .name!
                      .substring(0, 11 - 1)),
              new TextSpan(
                  text:
                      ' ${Provider.of<RestaurantProvider>(context).selectedRestaurant!.name!.substring(11)}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConst.colorText)),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        leadingWidth: 50.w,
        leading: Builder(
          builder: (context) => IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.view_headline,
              color: ColorConst.primaryColor,
            ),
          ),
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, x) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text: 'Most Popular Categories',
                      fontSize: 24.sp,
                    ),
                    Container(
                      width: double.infinity,
                      height: 170.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      provider.mostPopularList[index].image!),
                                  minRadius: 40.r,
                                  maxRadius: 60.r,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomText(
                                    text:
                                        provider.mostPopularList[index].name!),
                              ],
                            ),
                          );
                        },
                        itemCount: provider.mostPopularList.length,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
                Container(
                  child: CustomText(
                    text: 'Best Deals',
                    colorText: Colors.black,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: provider.bestDealsList
                        .map(
                          (e) => Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 3.w, sigmaY: 3.h),
                                        child: CachedNetworkImage(
                                          imageUrl: e.image!,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Center(
                                            child: Icon(Icons.image),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CustomText(
                                          text: '${e.name}',
                                          fontSize: 16.sp,
                                          colorText: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
