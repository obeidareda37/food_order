import 'package:email_validator/email_validator.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/auth_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/auth_screen/login_screen.dart';
import 'package:fastfood_app/widget/custom_button/custom_button_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  static final routeName = 'ForgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FocusNode? emailFocusNode;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode = FocusNode();
  }

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 50.w,
        leading: IconButton(
          onPressed: () => RouteHelper.routeHelper.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: 240.w,
                  height: 248.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/forget.png'),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      margin: EdgeInsetsDirectional.only(start: 15.w),
                      child: CustomText(
                        text: easy.tr('forgetPasswordTitle'),
                        colorText: ColorConst.primaryColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 300.w,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CustomText(
                        text: easy.tr('forgetPasswordSubTitle'),
                        colorText: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CustomTextFormField(
                        borderRadius: 15.r,
                        labelText: easy.tr('emailAddress'),
                        requestFocus: () {
                          _requestFocus(emailFocusNode);
                        },
                        controller: provider.emailController,
                        myFocusNode: emailFocusNode,
                        validate: (value) {
                          if (value!.isEmpty || value == '') {
                            return easy.tr('validationEmailAddressEmpty');
                          }
                          if (!EmailValidator.validate(value)) {
                            return easy.tr('validationEmailAddressNotValid');
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      width: double.infinity,
                      height: 60.h,
                      child: CustomButtonWidget(
                        onPressed: () {
                          print('x');
                          setState(() {
                            if (formKey.currentState!.validate()) {
                              print('x');
                              provider.resetPassword();
                              return;
                            } else {
                              print('faild');
                            }
                          });
                        },
                        text: easy.tr('Send'),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          RouteHelper.routeHelper
                              .goToPageReplacement(LoginScreen.routeName);
                        },
                        child: CustomText(
                          colorText: ColorConst.primaryColor,
                          text: easy.tr('backToLogin'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
