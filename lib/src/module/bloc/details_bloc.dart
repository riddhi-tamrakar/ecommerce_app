import 'dart:convert';

import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:ecommerce_app/src/module/model/get_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import 'details_event.dart';
import 'details_state.dart';

class Details extends Bloc<DetailsEvent, DetailsState> {
  @override
  DetailsState get initialState => DetailsInitial();
  final database = openDatabase('products_databases.db');

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetData) {
      try {
        // yield Loading();
        List<GetDetails> _data = await getData(event.page, event.perpage);

        yield FetchData(obj: _data);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
    if (event is GetMyCartDetails) {
      try {
        yield Loading();
        List<CartData> _data = await convertData();

        yield FetchMyCartData(obj: _data);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
    if (event is UpdateDetails) {
      try {
        yield Loading();
        await updateData(event.obj);
        List<CartData> _data = await convertData();

        yield FetchMyCartData(obj: _data);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
    if (event is DeleteItem) {
      try {
        yield Loading();
        await deleteData(event.id);
        List<CartData> _data = await convertData();

        yield FetchMyCartData(obj: _data);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
  }

  Future getData(page, perPage) async {
    try {
      final _body = jsonEncode({'page': "$page", 'perPage': "$perPage"});

      final response = await http.post(
          "http://205.134.254.135/~mobile/MtProject/api/v1/product_list",
          headers: {
            'Content-Type': 'application/json',
            'token':
                "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
          },
          body: _body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["message"] == "success") {
          final data2 = data["data"] as List;

          return data2.map((i) {
            return GetDetails(
                i["id"],
                i["description"],
                i["status"],
                i["title"],
                i["price"],
                i["featured_image"],
                data["totalRecord"],
                int.parse(data["perPage"]));
          }).toList();
        } else {
          throw ("something went wrong...");
        }
      } else {
        throw ("something went wrong...");
      }
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("No Internet Connection.");
      } else {
        throw ("something went wrong");
      }
    }
  }

  Future<void> addToCart(CartData data) async {
    final db = await database;

    await db.insert(
      'cartData',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartData>> convertData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('cartData');

    return List.generate(maps.length, (i) {
      return CartData(
          id: maps[i]['id'],
          name: maps[i]['name'],
          qty: maps[i]['qty'],
          price: maps[i]['price'],
          imgUrl: maps[i]['imgUrl']);
    });
  }

  Future<void> updateData(CartData data) async {
    // Get a reference to the database.
    final db = await database;

    await db.update(
      'cartData',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> deleteData(int id) async {
    final db = await database;

    await db.delete(
      'cartData',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
