import 'package:ecommerce_app/src/module/bloc/details_bloc.dart';
import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:ecommerce_app/src/module/model/get_data.dart';
import 'package:ecommerce_app/src/module/ui/mycart.dart';
import 'package:ecommerce_app/src/services/utility.dart';
import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:ecommerce_app/src/widgets/shadow_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_button_widget.dart';

class ListDataItem extends StatelessWidget {
  List<GetDetails> obj;
  int index;
  Details _bloc = Details();

  ListDataItem(
    this.obj,
    this.index,
  );

  addProductTocart(context, objdetail) async {
    var fido = CartData(
        id: objdetail.id,
        name: objdetail.title,
        qty: 1,
        price: objdetail.price,
        imgUrl: objdetail.imgUrl);

    await _bloc.addToCart(fido);
    print(await _bloc.convertData());

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyCartPage())); //
  }

  Widget addToCart(context, objdetail) => GestureDetector(
        onTap: () {
          addProductTocart(context, objdetail);
        },
        child: Container(
            child: Row(
          children: [
            Text(
              'Add To Cart',
              style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: Utility.displayHeight(context) * 0.020,
                  color: AppTheme.kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: Utility.displayHeight(context) * 0.01,
            ),
            Icon(
              Icons.shopping_cart,
              size: Utility.displayHeight(context) * 0.023,
              color: AppTheme.kPrimaryColor,
            )
          ],
        )),
      );

  Widget _content(obj, index, context) => Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ProductDetails(obj: obj[index])));
            },
            child: CustomCard(
              child: ListTile(
                leading: Image.network(
                  '${obj[index].imgUrl != null ? obj[index].imgUrl : "https://picsum.photos/250?image=9"}',
                ),
                title: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 15.0),
                    child: Text(
                      '${obj[index].title != null ? obj[index].title : "NA"}',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: AppTheme.kBodyText2FontSize,
                          color: AppTheme.kFontColor1,
                          fontWeight: FontWeight.w500),
                    )),
                subtitle: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 8.0, bottom: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u{20B9}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: AppTheme.kBodyText2FontSize,
                                    color: AppTheme.kFontColor1,
                                    fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: Utility.displayWidth(context) * 0.02,
                          ),
                          Expanded(
                            child: Text(
                              '${obj[index].price != null ? obj[index].price : "NA"}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      fontSize: AppTheme.kBodyText2FontSize,
                                      color: AppTheme.kFontColor1,
                                      fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 8, top: 8.0, bottom: 15.0),
                        child: addToCart(context, obj[index])),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        _content(obj, index, context),
      ],
    ));
  }
}
