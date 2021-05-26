import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/services/utility.dart';

class CommonButtonWidget extends StatelessWidget {
  final String buttonText;
  final double borderRadius;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final ValueChanged onTap;
  final bool isLoading;
  final double fontsize;
  final double buttonwidth;
  CommonButtonWidget(
      {Key key,
      @required this.buttonText,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      this.onTap,
      this.borderRadius,
      this.isLoading,
      this.fontsize,
      this.buttonwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(true);
      },
      child: Container(
        width: buttonwidth != null
            ? buttonwidth
            : Utility.displayWidth(context) * 0.75,
        padding: EdgeInsets.all(Utility.displayHeight(context) * 0.014),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.5),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
              borderRadius ?? Utility.displayHeight(context) * 0.006),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading != null && isLoading
                ? Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            AppTheme.kPrimaryColor)),
                  )
                : Container(),
            Text(
              '$buttonText',
              style: TextStyle(
                  color: textColor,
                  fontSize: fontsize,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
