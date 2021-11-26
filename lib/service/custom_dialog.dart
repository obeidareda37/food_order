import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCustomDialog({
    String? message,
    Function? function,
    String? title,
    bool isNo = true,
  }) {
    showDialog(
        context: RouteHelper.routeHelper.navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: CustomText(
              text: title!,
              colorText: ColorConst.primaryColor,
            ),
            content: CustomText(
              text: message!,
              colorText: ColorConst.primaryColor,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (function == null) {
                    RouteHelper.routeHelper.back();
                  } else {
                    function();
                    RouteHelper.routeHelper.back();
                  }
                },
                child: CustomText(
                  text: isNo?'Yes':'Ok',
                  colorText: ColorConst.colorText,
                ),
              ),
              isNo
                  ? TextButton(
                      onPressed: () {
                        RouteHelper.routeHelper.back();
                      },
                      child: CustomText(
                        text: 'No',
                        colorText: ColorConst.colorText,
                      ))
                  : Container()
            ],
          );
        });
  }
}
