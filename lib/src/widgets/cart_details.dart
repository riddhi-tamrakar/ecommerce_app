import 'package:ecommerce_app/src/module/bloc/details_bloc.dart';
import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:ecommerce_app/src/services/utility.dart';
import 'package:ecommerce_app/src/styles/theme.dart';
import 'package:ecommerce_app/src/widgets/shadow_widget.dart';
import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class ListCartDataItem extends StatelessWidget {
  List<CartData> obj;
  int index;
  ValueChanged onDelete;
  ValueChanged onUpdate;
  Details _bloc = Details();

  int counter = 0;
  ListCartDataItem(
      {Key key, this.obj, this.index, this.onDelete, this.onUpdate})
      : super(key: key);

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
                    '${obj[index].name != null ? obj[index].name : "NA"}',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: AppTheme.kBodyText2FontSize,
                        color: AppTheme.kSecondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                subtitle: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 8.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\u{20B9} ${obj[index].price != null ? obj[index].price * obj[index].qty : "NA"}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: AppTheme.kBodyText2FontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CustomCard(
                            child: DropdownWidget(
                              fieldWidth: Utility.displayWidth(context) * 0.15,
                              label:
                                  ' ${obj[index].qty != 1 ? obj[index].qty : "QTY"}',
                              options: ['1', '2', '3', '4', '5', '6'],
                              onChanged: (value) {
                                var data = CartData(
                                    id: obj[index].id,
                                    name: obj[index].name,
                                    qty: int.parse(value),
                                    price: obj[index].price,
                                    imgUrl: obj[index].imgUrl);

                                onUpdate(data);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    onDelete(obj[index].id);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.black,
                  ),
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
