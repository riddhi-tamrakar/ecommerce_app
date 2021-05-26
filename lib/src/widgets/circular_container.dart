import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final Widget child;
  final double padding;
  final double size;
  CircularContainer(
      {Key key,
      this.color,
      @required this.child,
      this.padding,
      this.size,
      this.bgColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(padding != null ? padding : 0),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: color != null ? color : Colors.grey,
          ),
        ),
        child: child);
  }
}
