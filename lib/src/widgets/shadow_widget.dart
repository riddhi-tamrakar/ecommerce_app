import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;

  CustomCard({Key key, this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.kBorderRadius),
            topRight: Radius.circular(AppTheme.kBorderRadius),
            bottomLeft: Radius.circular(AppTheme.kBorderRadius),
            bottomRight: Radius.circular(AppTheme.kBorderRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
