// import 'package:ecommerce_app/src/app.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(App());
// }
import 'dart:async';

import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(App());

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'products_databases.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE cartData(id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, price INTEGER, imgUrl TEXT)',
      );
    },
    version: 1,
  );
}
