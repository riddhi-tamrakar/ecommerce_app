import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/services/utility.dart';

class AppTheme {
  //
  AppTheme._();

  //Colors

  static const kPrimaryColor = Color(0xffff4c02);
  static const kBackgroundColor = Color(0xffF8F8F8);
  static const kOnPrimaryColor = Colors.white;
  static const kSecondaryColor = Color(0xffa6a6a6);
  static const kIconColor = Color(0xffa6a6a6);
  static const Color kFontColor1 = Colors.black;
  static const Color kFontColor2 = Colors.white;
  static const Color kOutlineColor = Color(0xffb7b7b7);

  //Font-sizes
  static const double kButtonFontSize = 18.0;
  static const double kCaptionFontSize = 13.0;
  static const double kPageTitleFontSize = 27.0;
  static const double kPageTitleFontSize2 = 24.0;
  static const double kTitleFontSize = 22.0;
  static const double kItemTitleFontSize = 20.0;
  static const double kBodyText1FontSize = 12.0;
  static const double kBodyText2FontSize = 14.0;
  //Borders
  static const double kBorderRadius = 10.0;
  static const double kBorderWidth = 1.0;

  //Paddings
  static const double kBodyPadding = 20.0;
  static const double kSpaceBetweenInputFields = 20.0;
  static const double kSpaceBetweenHomeCards = 18.0;

  //Others

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: kPrimaryColor,
    errorColor: Colors.red,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(
      foregroundColor: kOnPrimaryColor,
      backgroundColor: kPrimaryColor,
      iconTheme: IconThemeData(
        color: kPrimaryColor,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      onPrimary: kOnPrimaryColor,
      // primaryVariant: Colors.white38,
      secondary: kSecondaryColor,
    ),
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor, foregroundColor: kOnPrimaryColor),
    iconTheme: IconThemeData(
      color: kIconColor,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
          fontFamily: 'Poppins',
          // Being used as page title
          color: kOnPrimaryColor,
          fontSize: kPageTitleFontSize,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          // For small page titles
          color: kFontColor1,
          fontSize: kPageTitleFontSize2,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: Colors.black,
          fontSize: kItemTitleFontSize,
          fontWeight:
              FontWeight.w500), // Used for Home page item tiles e.g. Robots
      headline5: TextStyle(
          color: kIconColor, fontSize: 10, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          color: kFontColor1,
          fontSize: kBodyText2FontSize,
          fontWeight: FontWeight.normal), // For smaller sizes
      bodyText2: TextStyle(
          color: kFontColor1,
          fontSize: kBodyText2FontSize,
          fontWeight: FontWeight.normal), // For Larger sizes
      caption: TextStyle(
          fontSize: kCaptionFontSize,
          color: kOutlineColor,
          fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: kBorderWidth, color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kBorderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: kBorderWidth, color: kSecondaryColor),
          borderRadius: BorderRadius.circular(kBorderRadius)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontSize: kButtonFontSize, fontWeight: FontWeight.w600)),
            minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(56)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(kBorderRadius))),
            foregroundColor:
                MaterialStateProperty.all<Color>(kOnPrimaryColor))),
  );
}
