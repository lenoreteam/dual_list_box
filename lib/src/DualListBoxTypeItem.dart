import 'dart:convert';
import 'DualListBoxTypeWidget.dart';

class DualListBoxTypeItem {
  String name;
  bool isSelected;
  DualListBoxTypeWidget? widget;
  DualListBoxTypeItem({
    required this.name,
    required this.isSelected,
    this.widget,
  });

  DualListBoxTypeItem copyWith({
    String? name,
    bool? isSelected,
    DualListBoxTypeWidget? widget,
  }) {
    return DualListBoxTypeItem(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      widget: widget ?? this.widget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory DualListBoxTypeItem.fromMap(Map<String, dynamic> map) {
    return DualListBoxTypeItem(
      name: map['name'],
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DualListBoxTypeItem.fromJson(String source) =>
      DualListBoxTypeItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'DualListBoxTypeItem(name: $name, isSelected: $isSelected, widget: $widget)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DualListBoxTypeItem &&
        other.name == name &&
        other.isSelected == isSelected &&
        other.widget == widget;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode ^ widget.hashCode;
}
