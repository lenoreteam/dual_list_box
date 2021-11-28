import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:dual_list_box/src/DualListBoxViewModel.dart';
import 'package:flutter/material.dart';
import 'package:lenore_ui/lenore_ui.dart';
import 'package:provider/provider.dart';

/// A package to make assigning or uassigning from one list to another an easy task.
///
/// [items] is a list that contains both assigned and unassigned lists. It is a list of [DualListBoxItem]s.
/// If the [DualListBoxItem.isSelected] is true, then the item will be in assigned list.
/// see example applicatio on github for a working example.
///
/// This package is responsive to different screen sizes
class DualListBox extends StatelessWidget {
  /// The [title] that will be shown on top of the widget.
  final String? title;

  /// This is the [backgroundColor] of the whole widget.
  final Color backgroundColor;

  /// List of [items] to be shown in the unassigned list. this list should include all the items.
  final List<DualListBoxItem> items;

  /// Determine if the lists can be filtered by their item type.
  final bool filterByType;

  /// To show or not show the search widget. To be able to search through lists by their title.
  final bool searchable;

  /// If [isLoading] is true, A loading widget will be shown on top of all widgets.
  final bool isLoading;

  /// Gets called when user assigns a new item to assigned list. Return the assigned [item].
  final Function(dynamic item)? onAssign;

  /// Gets called when user assigns all items to assigned list. Return the [assignedItems].
  final Function(List<DualListBoxItem> assignedItems)? onAssignAll;

  /// Gets called when user removes an item from assigned list. Return the removed [item].
  final Function(dynamic item)? onRemove;

  /// Gets called when user removes all the items from assigned list. Return the [removedItems].
  final Function(List<DualListBoxItem> removedItems)? onRemoveAll;

  /// Gets called whenever a change happens. It returns all the [items].
  final Function(List<DualListBoxItem> items)? onChange;

  /// Height of the widget
  final double listHeight;

  /// Width of the widget
  final double? widgetWidth;
  const DualListBox({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.items = const [],
    this.filterByType = false,
    this.searchable = false,
    this.isLoading = false,
    this.onAssign,
    this.onAssignAll,
    this.onRemove,
    this.onRemoveAll,
    this.onChange,
    this.listHeight = 350,
    this.widgetWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DualListBoxViewModel()),
      ],
      child: Consumer<DualListBoxViewModel>(builder: (_, consumer, __) {
        return Container(
          child: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? _buildDesktopWidget(context, consumer)
              : _buildMobileWidget(context, consumer),
        );
      }),
    );
    // return Responsive.isDesktop(context) || Responsive.isTablet(context)
    //     ? _buildDesktopWidget(context)
    //     : _buildMobileWidget(context);
  }

  _buildMobileWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Container(
      height: listHeight,
      color: Colors.green,
    );
  }

  _buildDesktopWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          // title ? _titleWidget() : Container(),
          // (searchable && Responsive.isMobile(context)) ? _searchWidget(): Container(),
          // filterByType ? _filterWidget() : Container(),
          _listsWidget(context, consumer),
        ],
      ),
    );
  }

  Widget _listsWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Container(
      height: listHeight,
      width: widgetWidth,
      child: Row(
        children: [
          _listWidget(consumer.unAssignedList),
          _listWidget(consumer.assignedList),
        ],
      ),
    );
  }

  Widget _listWidget(List<DualListBoxItem> unAssignedList) {
    return Container();
  }
}
