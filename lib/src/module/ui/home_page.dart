import 'package:ecommerce_app/src/module/bloc/details_bloc.dart';
import 'package:ecommerce_app/src/module/bloc/details_event.dart';
import 'package:ecommerce_app/src/module/bloc/details_state.dart';
import 'package:ecommerce_app/src/module/model/get_data.dart';
import 'package:ecommerce_app/src/services/utility.dart';
import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:ecommerce_app/src/widgets/details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/details_event.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static int page = 1;
  ScrollController _sc = new ScrollController();
  Details _bloc = Details();
  List<GetDetails> products = new List();
  int totalLength;
  bool isLoading = false;
  bool notCallApi = false;

  void initState() {
    super.initState();
    this._getMoreData(page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        if (notCallApi) {
        } else {
          _getMoreData(page);
        }
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      _bloc.add(GetData(perpage: 10, page: page));
    }
  }

  getProductlist(data) {
    List<GetDetails> tList = new List();
    for (int i = 0; i < data.length; i++) {
      tList.add(data[i]);
    }
    setState(() {
      totalLength = data[0].totalRecord;
      isLoading = false;
      products.addAll(tList);
      page++;

      if (totalLength == products.length) {
        notCallApi = true;
      } else {}
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppTheme.kPrimaryColor,
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(Utility.displayHeight(context) * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: Utility.displayHeight(context) * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Product",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: AppTheme.kPrimaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: new Divider(
                    height: 15.0,
                    color: Colors.black26,
                  ),
                ),
                BlocBuilder(
                    bloc: _bloc,
                    builder: (BuildContext context, DetailsState state) {
                      if (state is FetchData) {
                        return state.obj != null && state.obj.length > 0
                            ? Expanded(
                                child: Padding(
                                padding: EdgeInsets.all(
                                    Utility.displayWidth(context) * 0.035),
                                child: ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    controller: _sc,
                                    itemCount: products.length + 1,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      if (index == products.length) {
                                        return _buildProgressIndicator();
                                      } else {
                                        return ListDataItem(
                                          products,
                                          index,
                                        );
                                      }
                                    }),
                              ))
                            : Container(
                                padding: EdgeInsets.only(
                                    top: Utility.displayHeight(context) * 0.2),
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: AppTheme.kButtonFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                      } else {
                        return Container();
                      }
                    }),
                BlocListener<Details, DetailsState>(
                    bloc: _bloc,
                    listener: (context, state) {
                      if (state is FetchData) {
                        // ignore: unrelated_type_equality_checks
                        if (state.obj != null && state.obj != "") {
                          getProductlist(state.obj);
                        }
                      }
                    },
                    child: Container())
              ],
            ),
          ),
        ));
  }
}
