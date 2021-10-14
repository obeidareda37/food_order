import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/auth_screen/register_screen.dart';
import 'package:fastfood_app/widget/custom_button/custom_button_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/onboarding_widget/onboarding_item.dart';
import 'package:fastfood_app/widget/onboarding_widget/page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class OnBoardingScreen extends StatefulWidget {
  static final routName = 'onBoarding';
  bool walk = true;

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  List<Widget> _pages = [
    onBoardingWidget(
      title: "onBoardingTitle1",
      description: 'onBoardingSubTitle1',
      image: 'assets/images/onboarding.png',
    ),
    onBoardingWidget(
      title: 'onBoardingTitle2',
      description: 'onBoardingSubTitle2',
      image: 'assets/images/onboarding3.png',
    ),
    onBoardingWidget(
      title: 'onBoardingTitle3',
      description: 'onBoardingSubTitle3',
      image: 'assets/images/onboarding2.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // widget.walk =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onChanged,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < _pages.length; i++)
                          i == _currentPage
                              ? buildPageIndicator(true)
                              : buildPageIndicator(false),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomButtonWidget(
                      onPressed: (){
                        setState(() {
                          if (_currentPage == 0) {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          } else if (_currentPage == 1) {
                            _pageController.animateToPage(2,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          } else {
                            RouteHelper.routeHelper.goToPageReplacement(
                              RegisterScreen.routeName,
                            );
                          }
                        });
                      },
                      text: _currentPage == 2
                          ? easy.tr("onBoardingStartedButton")
                          : easy.tr("onBoardingNextButton"),
                    ),


                    // MaterialButton(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadiusDirectional.circular(25.r)),
                    //   splashColor: Colors.transparent,
                    //   highlightColor: Colors.transparent,
                    //   highlightElevation: 0,
                    //   color: ColorConst.primaryColor,
                    //   onPressed: () {
                    //
                    //   },
                    //   child: CustomText(
                    //     text: _currentPage == 2
                    //         ? easy.tr("onBoardingStartedButton")
                    //         : easy.tr("onBoardingNextButton"),
                    //     colorText: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20.sp,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
