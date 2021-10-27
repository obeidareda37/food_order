import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/custom_dialog.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/service/server_item_offset.dart';
import 'package:fastfood_app/widget/custom_button/custom_button_widget.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/custom_text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  static const routeName = 'PlaceOrderScreen';
  var paymentSelected = 'COD';

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  FocusNode? fNameFocusNode;
  FocusNode? lNameFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? commentFocusNode;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _requestFocus(focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  @override
  void initState() {
    super.initState();
    fNameFocusNode = FocusNode();
    lNameFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    commentFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<CartProvider, RestaurantProvider>(
        builder: (context, cartProvider, restProvider, x) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: CustomText(
                text: PLACE_ORDER_TEXT,
                colorText: ColorConst.primaryColor,
              ),
              leading: IconButton(
                onPressed: () {
                  RouteHelper.routeHelper.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: ColorConst.primaryColor,
                ),
              ),
              leadingWidth: 50.w,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: cartProvider.fNameController,

                            onChange: (value) {},
                            borderRadius: 15.r,
                            labelText: FIRST_NAME,
                            requestFocus: () {
                              _requestFocus(fNameFocusNode);
                            },
                            // controller: provider.emailController,
                            myFocusNode: fNameFocusNode,
                            validate: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Please Enter First Name';
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            controller: cartProvider.lNameController,

                            onChange: (value) {},
                            borderRadius: 15.r,
                            labelText: LAST_NAME,
                            requestFocus: () {
                              _requestFocus(lNameFocusNode);
                            },
                            // controller: provider.emailController,
                            myFocusNode: lNameFocusNode,
                            validate: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Please Enter last Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: cartProvider.addressController,
                          onChange: (value) {},
                          borderRadius: 15.r,
                          labelText: ADDRESS_TEXT,
                          requestFocus: () {
                            _requestFocus(addressFocusNode);
                          },
                          // controller: provider.emailController,
                          myFocusNode: addressFocusNode,
                          validate: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Please Enter Your Address';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: PAYMENT_TEXT,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                        RadioListTile<String>(
                            title: CustomText(
                              text: COD_TEXT,
                            ),
                            value: COD_VAL,
                            groupValue: widget.paymentSelected,
                            onChanged: (String? value) {
                              widget.paymentSelected = value!;
                              setState(() {});
                            }),
                        RadioListTile<String>(
                            title: CustomText(
                              text: BRAINTREE_TEXT,
                            ),
                            value: BRAINTREE_VAL,
                            groupValue: widget.paymentSelected,
                            onChanged: (String? value) {
                              widget.paymentSelected = value!;
                              setState(() {});
                            })
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: cartProvider.commentController,
                          onChange: (value) {},
                          borderRadius: 15.r,
                          labelText: COMMENT_TEXT,
                          requestFocus: () {
                            _requestFocus(commentFocusNode);
                          },
                          // controller: provider.emailController,
                          myFocusNode: commentFocusNode,
                          validate: (value) {},
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                      width: double.infinity,
                      height: 50.h,
                      child: CustomButtonWidget(
                        onPressed: () async {
                          var serverTime = await getServerTimeOffset();
                          var restaurantId =
                              restProvider.selectedRestaurant!.restaurantId!;
                          if (formKey.currentState!.validate()) {
                            var order = OrderModel(
                              userPhone: '',
                              restaurantId: restaurantId,
                              cartItemList: cartProvider.getCart(restaurantId),
                              comment: cartProvider.commentController.text,
                              discount: 0,
                              userName:
                                  '${cartProvider.fNameController.text} ${cartProvider.lNameController.text}',
                              shippingAddress:
                                  cartProvider.addressController.text,
                              orderNumber: cartProvider
                                  .createOrderNumber(serverTime)
                                  .toString(),
                              totalPayment:
                                  cartProvider.getSubTotal(restaurantId),
                              finalPayment: cartProvider.calculateFinalPayment(
                                  cartProvider.getSubTotal(restaurantId), 0),
                              shippingCost:
                                  cartProvider.getShippingFee(restaurantId),
                              isCod: widget.paymentSelected == COD_VAL
                                  ? true
                                  : false,
                              orderStatus: 0,
                              createdDate: serverTime,
                            );
                            print('x');
                            cartProvider.writeOrderToFirebase(order);
                            // if (cartProvider.isSuccess) {
                            //   CustomDialog.customDialog.showCustomDialog(
                            //     title: 'order Success',
                            //     message: 'Your order has been placed',
                            //   );
                            // } else {
                            //   CustomDialog.customDialog.showCustomDialog(
                            //     title: 'order failed',
                            //     message: 'Your order submit failed',
                            //   );
                            // }
                            return;
                          } else {
                            print('faild');
                          }
                        },
                        text: PLACE_ORDER_TEXT,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
