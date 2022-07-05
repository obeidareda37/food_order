import 'package:email_validator/email_validator.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/auth_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/auth_screen/forget_password.dart';
import 'package:fastfood_app/view/auth_screen/register_screen.dart';
import 'package:fastfood_app/widget/custom_button/custom_button_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  FocusNode? emailFocusNode;

  FocusNode? passwordFocusNode;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[50],
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.grey[50],
      ),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, provider, x) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 248.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/login.png'),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 15.w),
                            child: CustomText(
                              text: easy.tr('loginTitle'),
                              colorText: ColorConst.colorText,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CustomText(
                              text: easy.tr('loginSubTitle'),
                              colorText: Colors.grey,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 400.h,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    onChange: (value){},
                                    borderRadius: 15.r,
                                    labelText: easy.tr('emailAddress'),
                                    requestFocus: () {
                                      _requestFocus(emailFocusNode);
                                    },
                                    controller: provider.emailController,
                                    myFocusNode: emailFocusNode,
                                    validate: (value) {
                                      if (value!.isEmpty || value == '') {
                                        return easy
                                            .tr('validationEmailAddressEmpty');
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return easy.tr(
                                            'validationEmailAddressNotValid');
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomTextFormField(
                                    onChange: (value){},

                                    borderRadius: 15.r,
                                    controller: provider.passwordController,
                                    labelText: easy.tr('password'),
                                    requestFocus: () {
                                      _requestFocus(passwordFocusNode);
                                    },
                                    myFocusNode: passwordFocusNode,
                                    validate: (value) {
                                      if (value!.isEmpty || value == '') {
                                        print('empty');
                                        return easy
                                            .tr('validationPasswordEmpty');
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      RouteHelper.routeHelper
                                          .goToPage(ForgetPassword.routeName);
                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: CustomText(
                                        text: easy.tr('forgetPassword'),
                                        colorText: ColorConst.primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.w,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 60.h,
                                    child: CustomButtonWidget(
                                      onPressed: () {
                                        print('x');
                                        setState(() {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print('x');
                                            provider.login();
                                            return;
                                          } else {
                                            print('faild');
                                          }
                                        });
                                      },
                                      text: easy.tr('singIn'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: easy.tr('loginNewUser'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        RouteHelper.routeHelper
                                            .goToPage(RegisterScreen.routeName);
                                      },
                                      child: CustomText(
                                        text: easy.tr('singUp'),
                                        colorText: ColorConst.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
