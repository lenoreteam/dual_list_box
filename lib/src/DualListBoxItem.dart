import 'dart:convert';

import 'package:flutter/material.dart';

import 'DualListBox.dart';
import 'DualListBoxItemWidget.dart';

class DualListBoxItem {
  /// Determines if the item is selected and should be on assigned list.
  bool? isSelected;

  /// The type of the item. can be any string.
  ///
  /// When [DualListBox.filterByType] is true, the distinct type wil be available for filtering
  String? type;

  /// The [title] of the item to be used in search.
  String? title;

  /// The [widget] the will be shown in the list. Can be a custom widget or [DualListBoxItemWidget].
  ///
  /// If [widget] is null, then the title will be used in a [Text] widget in the lists.
  Widget? widget;
  DualListBoxItem({
    this.isSelected,
    this.type,
    this.title,
    this.widget,
  }) : assert(widget != null || title != null,
            'Both title and widget can not be null');

  DualListBoxItem copyWith({
    bool? isSelected,
    String? type,
    String? title,
    Widget? widget,
  }) {
    return DualListBoxItem(
      isSelected: isSelected ?? this.isSelected,
      type: type ?? this.type,
      title: title ?? this.title,
      widget: widget ?? this.widget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSelected': isSelected,
      'type': type,
      'title': title,
    };
  }

  factory DualListBoxItem.fromMap(Map<String, dynamic> map) {
    return DualListBoxItem(
      isSelected: map['isSelected'] != null ? map['isSelected'] : null,
      type: map['type'] != null ? map['type'] : null,
      title: map['title'] != null ? map['title'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DualListBoxItem.fromJson(String source) =>
      DualListBoxItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DualListBoxItem(isSelected: $isSelected, type: $type, title: $title, widget: $widget)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DualListBoxItem &&
        other.isSelected == isSelected &&
        other.type == type &&
        other.title == title &&
        other.widget == widget;
  }

  @override
  int get hashCode {
    return isSelected.hashCode ^
        type.hashCode ^
        title.hashCode ^
        widget.hashCode;
  }
}
