import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class Utility {
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  static String formatDate(String format, String dateTime) {
    try {
      String timeFormat =
          DateFormat("$format").format(DateTime.parse(dateTime));
      return timeFormat;
    } catch (e) {
      return '';
    }
  }

  static selectDate(context, callback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newdate) {
                  callback(newdate);
                },
                use24hFormat: true,
                maximumDate: new DateTime.now(),
                minimumYear: 1980,
                maximumYear: new DateTime.now().year,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
              ));
        });
  }

  static selectTime(context, callback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3.5,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newdate) {
                  callback(newdate);
                },
                use24hFormat: false,
                maximumDate: new DateTime.now(),
                minimumYear: 1980,
                maximumYear: new DateTime.now().year,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.time,
              ));
        });
  }

  static void showSnackBar(_scaffoldKey, msg, context) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("$msg",
          style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.w600)),
      duration: Duration(seconds: 3),
    ));
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void upliftPage(context, _scrollController) {
    var d = MediaQuery.of(context).viewInsets.bottom;
    if (d > 0) {
      Timer(
          Duration(milliseconds: 50),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }
}
