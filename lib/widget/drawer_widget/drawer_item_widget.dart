import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  String text;
  IconData icon;
  Function onTap;

  DrawerItemWidget(
      {required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 30,
            ),
            CustomText(
              text: text,
              fontSize: 18,
              colorText: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ],
        ),
      ),
    );
  }
}
