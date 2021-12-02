import 'package:flutter/material.dart';

class DualListBoxTypeWidget extends StatelessWidget {
  final String name;
  final bool isSelected;
  const DualListBoxTypeWidget(
      {Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).backgroundColor,
        border: isSelected
            ? null
            : Border.all(
                color: Colors.black26,
              ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ]
            : [],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).textTheme.subtitle2!.color,
            ),
      ),
    );
  }
}
