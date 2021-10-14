import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastfood_app/model/restaurant_model/cart_model.dart';
import 'package:flutter/material.dart';

class CartImageWidget extends StatelessWidget {
  CartModel cartModel;

  CartImageWidget({required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: cartModel.image,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return Center(
          child: Icon(Icons.image),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
