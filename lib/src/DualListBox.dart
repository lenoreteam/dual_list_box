import 'package:dual_list_box/dual_list_box.dart';
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

  /// List of [unassignedItems] to be shown in the unassigned list..
  final List<DualListBoxItem> unassignedItems;

  /// List of [assignedItems] to be shown in the assignedItems list..
  final List<DualListBoxItem> assignedItems;

  /// Determine if the lists can be filtered by their item type.
  final bool filterByType;

  /// To show or not show the search widget. To be able to search through lists by their title.
  final bool searchable;

  /// If [isLoading] is true, A loading widget will be shown on top of all widgets.
  final bool isLoading;

  /// Gets called when user assigns a new item to assigned list.
  ///
  /// Returns the  newly [newlyAssignedItems] and all of [assignedItems] and all of [unassignedItems].
  final Function(
      List<DualListBoxItem> newlyAssignedItems,
      List<DualListBoxItem> assignedItems,
      List<DualListBoxItem> unassignedItems)? onAssign;

  /// Gets called when user assigns all items to assigned list.
  ///
  /// Returns the  newly [newlyAssignedItems] and all of [assignedItems] and all of [unassignedItems].
  final Function(
      List<DualListBoxItem> newlyAssignedItems,
      List<DualListBoxItem> assignedItems,
      List<DualListBoxItem> unassignedItems)? onAssignAll;

  /// Gets called when user removes an item from assigned list.
  ///
  /// Returns the  newly [newlyRemovedItems] and all of [assignedItems] and all of [unassignedItems].
  final Function(
      List<DualListBoxItem> newlyRemovedItems,
      List<DualListBoxItem> assignedItems,
      List<DualListBoxItem> unassignedItems)? onRemove;

  /// Gets called when user removes all the items from assigned list.
  ///
  /// Returns the newly [newlyRemovedItems] and all of [assignedItems] and all of [unassignedItems].
  final Function(
      List<DualListBoxItem> newlyRemovedItems,
      List<DualListBoxItem> assignedItems,
      List<DualListBoxItem> unassignedItems)? onRemoveAll;

  /// Gets called whenever a change happens. It returns all the [items].
  final Function(List<DualListBoxItem> assignedItems,
      List<DualListBoxItem> removedItems)? onChange;

  /// Height of the widget
  final double listHeight;

  /// Width of the widget
  final double? widgetWidth;

  /// [borderRadius] will be used in all widgets.
  final double borderRadius;
  const DualListBox({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.assignedItems = const [],
    this.unassignedItems = const [],
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
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DualListBoxViewModel()),
      ],
      child: Consumer<DualListBoxViewModel>(builder: (_, consumer, __) {
        consumer.setLists(assignedItems, unassignedItems);
        return Container(
          child: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? _buildDesktopWidget(context, consumer)
              : _buildMobileWidget(context, consumer),
        );
      }),
    );
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
          Stack(
            alignment: Alignment.center,
            children: [
              _listsWidget(context, consumer),
              _middleButtons(consumer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _middleButtons(DualListBoxViewModel consumer) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(borderRadius / 2),
          child: InkWell(
            onTap: () {
              List<DualListBoxItem> assignedItems =
                  consumer.assignSelectedItems();
              if (onAssign != null) {
                onAssign!(assignedItems, consumer.assignedList,
                    consumer.unAssignedList);
              }
              if (onChange != null) {
                onChange!(consumer.assignedList, consumer.unAssignedList);
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(borderRadius / 2),
          child: InkWell(
            onTap: () {
              List<DualListBoxItem> assignedtems = consumer.assignAllItems();
              if (onAssignAll != null) {
                onAssignAll!(assignedtems, consumer.assignedList,
                    consumer.unAssignedList);
              }
              if (onChange != null) {
                onChange!(consumer.assignedList, consumer.unAssignedList);
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.double_arrow_rounded,
                size: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(borderRadius / 2),
          child: InkWell(
            onTap: () {
              List<DualListBoxItem> removedItems =
                  consumer.removeSelectedItems();
              if (onRemove != null) {
                onRemove!(removedItems, consumer.assignedList,
                    consumer.unAssignedList);
              }
              if (onChange != null) {
                onChange!(consumer.assignedList, consumer.unAssignedList);
              }
            },
            child: Container(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(borderRadius / 2),
          child: InkWell(
            onTap: () {
              List<DualListBoxItem> removedItems = consumer.removeAllItems();
              if (onRemoveAll != null) {
                onRemoveAll!(removedItems, consumer.assignedList,
                    consumer.unAssignedList);
              }
              if (onChange != null) {
                onChange!(consumer.assignedList, consumer.unAssignedList);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius / 2),
              ),
              padding: EdgeInsets.all(12),
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.double_arrow_rounded,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listsWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Container(
      height: listHeight,
      width: widgetWidth,
      child: Row(
        children: [
          Expanded(child: _listWidget(consumer, context, false)),
          Expanded(child: _listWidget(consumer, context, true)),
        ],
      ),
    );
  }

  Widget _listWidget(
    DualListBoxViewModel consumer,
    BuildContext context,
    bool isAssignedList,
  ) {
    List<DualListBoxItem> list = consumer.unAssignedList;
    List<bool> selectedItems = consumer.selectedUnAssignedItems;
    if (isAssignedList) {
      list = consumer.assignedList;
      selectedItems = consumer.selectedAssignedItems;
    }
    return Container(
      margin: EdgeInsets.only(right: 4, left: 4),
      padding: EdgeInsets.only(
          right: isAssignedList ? 16 : 64,
          left: isAssignedList ? 64 : 16,
          top: 16,
          bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        // border: Border.all(color: Theme.of(context).dividerColor),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
          ),
          BoxShadow(
            color: Theme.of(context).cardColor,
            spreadRadius: -1.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Widget? widget;
          if (selectedItems[index]) {
            widget = list[index].selectedWidget ??
                DualListBoxItemWidget(
                  title: list[index].title ?? ' ',
                  backgroundColor: Theme.of(context).primaryColor,
                );
          } else {
            widget = list[index].widget ??
                DualListBoxItemWidget(title: list[index].title ?? ' ');
          }
          return InkWell(
            onTap: () {
              if (isAssignedList) {
                consumer.toggleSelectedAssignedItemByIndex(index);
              } else {
                consumer.toggleSelectedUnAssignedItemByIndex(index);
              }
            },
            child: widget,
          );
        },
      ),
    );
  }
}
