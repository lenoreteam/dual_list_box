import 'package:flutter/material.dart';

class DualListBoxGroupItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  const DualListBoxGroupItem(
      {Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).textTheme.subtitle1!.color,
            ),
      ),
    );
  }
}
