import 'package:ecommerce_app/src/services/utility.dart';
import 'package:ecommerce_app/src/styles/theme.dart';

import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String label;
  final List<String> options;
  final ValueChanged onChanged;
  final double fieldWidth;

  DropdownWidget(
      {Key key,
      this.label,
      @required this.options,
      this.onChanged,
      this.fieldWidth})
      : super(key: key);
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  static const _kFontFam = 'ImoAppIcon';
  static const _kFontPkg = null;
  String _value;

  Widget _body() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.fieldWidth != null
                ? widget.fieldWidth
                : Utility.displayWidth(context) * 0.71,
            // padding: const EdgeInsets.all(5),
            // decoration: BoxDecoration(
            //   color: AppTheme.kOnPrimaryColor,
            //   border: Border.all(
            //     color: AppTheme.kSecondaryColor.withOpacity(0.6),
            //   ),
            //   borderRadius: BorderRadius.all(Radius.circular(
            //           5.0) //                 <--- border radius here
            //       ),
            // ),

            child: DropdownButton(
                hint: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.caption,
                ),
                isExpanded: true,
                underline: Container(),
                value: _value,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.kPrimaryColor,
                  size: AppTheme.kPageTitleFontSize2,
                ),
                items: widget.options
                    .map<DropdownMenuItem>(
                      (i) => DropdownMenuItem(
                        child: Text('   $i'),
                        value: i,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                  widget.onChanged(value);
                }),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
