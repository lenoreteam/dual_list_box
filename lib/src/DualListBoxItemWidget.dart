import 'package:flutter/material.dart';

class DualListBoxItemWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  const DualListBoxItemWidget({
    Key? key,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      padding: EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
      margin: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      child: Row(
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: textStyle != null ? textStyle!.color : null,
                  size: 20,
                )
              : Container(),
          SizedBox(width: 16),
          Text(
            title,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
