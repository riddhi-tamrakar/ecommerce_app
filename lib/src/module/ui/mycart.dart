import 'package:ecommerce_app/src/module/bloc/details_bloc.dart';
import 'package:ecommerce_app/src/module/bloc/details_event.dart';
import 'package:ecommerce_app/src/module/bloc/details_state.dart';
import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:ecommerce_app/src/services/utility.dart';
import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:ecommerce_app/src/widgets/cart_details.dart';
import 'package:ecommerce_app/src/widgets/common_button_widget.dart';
import 'package:ecommerce_app/src/widgets/details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/details_event.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int totalPrice;

  Details _bloc = Details();
  var mag;

  void initState() {
    super.initState();
    _bloc.add(GetMyCartDetails());
  }

  showMessage() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Select Both Values"),
      duration: Duration(milliseconds: 2000),
    ));
  }

  updateDetails(obj) {
    var data = CartData(
        id: obj.id,
        name: obj.name,
        qty: obj.qty,
        price: obj.price,
        imgUrl: obj.imgUrl);
    _bloc.add(UpdateDetails(obj: data));
  }

  calculateAmount(obj) {
    totalPrice = 0;
    for (int i = 0; i < obj.length; i++) {
      totalPrice = totalPrice + obj[i].price * obj[i].qty;
    }
    return totalPrice;
  }

  Widget placeOrder() => Container(
        child: CommonButtonWidget(
          buttonwidth: Utility.displayWidth(context) * 0.82,
          buttonText: 'Place Order',
          borderRadius: 5,
          backgroundColor: Colors.green,
          borderColor: Colors.green,
          textColor: AppTheme.kOnPrimaryColor,
          // isLoading: state is Loading ? true : false,
          fontsize: AppTheme.kItemTitleFontSize,
          onTap: (val) {},
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppTheme.kPrimaryColor,
      ),
      body: Container(
        child: BlocBuilder(
            bloc: _bloc,
            builder: (BuildContext context, DetailsState state) {
              if (state is FetchMyCartData) {
                print("state called");
                return state.obj != null && state.obj.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(
                            Utility.displayHeight(context) * 0.02),
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
                                  "My Cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: AppTheme.kPrimaryColor),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(
                                  Utility.displayWidth(context) * 0.035),
                              child: ListView.builder(
                                  itemCount: state.obj.length,
                                  // itemBuilder: (_, int index) => listDataItem(state.obj),
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return ListCartDataItem(
                                      obj: state.obj,
                                      index: index,
                                      onDelete: (value) {
                                        _bloc.add(DeleteItem(id: value));
                                      },
                                      onUpdate: (value) {
                                        updateDetails(value);
                                      },
                                    );
                                  }),
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.kItemTitleFontSize,
                              ),
                              child: new Divider(
                                height: AppTheme.kItemTitleFontSize,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                AppTheme.kItemTitleFontSize,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize:
                                                AppTheme.kItemTitleFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\u{20B9} ${calculateAmount(state.obj) != null ? calculateAmount(state.obj) : state.obj[0].price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize:
                                                AppTheme.kItemTitleFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            placeOrder()
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          " Data Not Found",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: AppTheme.kButtonFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
              } else if (state is Loading) {
                return Container(
                    padding: EdgeInsets.only(
                        top: Utility.displayHeight(context) * 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      )),
                    ));
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
