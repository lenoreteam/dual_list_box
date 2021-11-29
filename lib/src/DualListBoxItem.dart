import 'dart:convert';

import 'package:flutter/material.dart';

import 'DualListBox.dart';
import 'DualListBoxItemWidget.dart';

class DualListBoxItem {
  /// Determines if the item is in assigned list.
  bool? isAssigned;

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

  /// The [selectedWidget] is shown when [isSelected] is true. Can be a custom widget or [DualListBoxItemWidget].
  ///
  /// If [selectedWidget] is null, then the title will be used in a [Text] widget in the lists.
  Widget? selectedWidget;
  DualListBoxItem({
    this.type,
    this.title,
    this.widget,
    this.isAssigned = false,
    this.selectedWidget,
  }) : assert(widget != null || title != null,
            'Both title and widget can not be null');

  DualListBoxItem copyWith({
    bool? isAssigned,
    String? type,
    String? title,
    Widget? widget,
    Widget? selectedWidget,
  }) {
    return DualListBoxItem(
      isAssigned: isAssigned ?? this.isAssigned,
      type: type ?? this.type,
      title: title ?? this.title,
      widget: widget ?? this.widget,
      selectedWidget: selectedWidget ?? this.selectedWidget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAssigned': isAssigned,
      'type': type,
      'title': title,
    };
  }

  factory DualListBoxItem.fromMap(Map<String, dynamic> map) {
    return DualListBoxItem(
      isAssigned: map['isAssigned'] != null ? map['isAssigned'] : null,
      type: map['type'] != null ? map['type'] : null,
      title: map['title'] != null ? map['title'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DualListBoxItem.fromJson(String source) =>
      DualListBoxItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DualListBoxItem(isAssigned: $isAssigned, type: $type, title: $title, widget: $widget)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DualListBoxItem &&
        other.isAssigned == isAssigned &&
        other.type == type &&
        other.title == title &&
        other.widget == widget &&
        other.selectedWidget == selectedWidget;
  }

  @override
  int get hashCode {
    return isAssigned.hashCode ^
        type.hashCode ^
        title.hashCode ^
        widget.hashCode ^
        selectedWidget.hashCode;
  }
}
