import 'package:auto_size_text/auto_size_text.dart';
import 'package:dual_list_box/dual_list_box.dart';
import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:dual_list_box/src/DualListBoxTypeWidget.dart';
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

  /// The [assignTitle] that will be shown on top of the assigned list.
  final String? assignTitle;

  /// The [unAssignTitle] that will be shown on top of the unAssignTitle list.
  final String? unAssignTitle;

  /// This is the [backgroundColor] of the whole widget.
  final Color backgroundColor;

  /// List of [unassignedItems] to be shown in the unassigned list..
  final List<DualListBoxItem> unassignedItems;

  /// List of [assignedItems] to be shown in the assignedItems list..
  final List<DualListBoxItem> assignedItems;

  /// Determine if the lists can be filtered by their item type.
  ///
  /// When a type is selected to filter the list, the items that are not the same type, will be hidden instead of removing them.
  /// This means the selected status of them will be reserved.
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

  /// Height of the lists on web / desktop
  final double listHeightDesktop;

  /// Height of the lists on web / desktop
  final double? listHeightMobile;

  /// Width of the widget
  final double? widgetWidth;

  /// [borderRadius] will be used in all widgets.
  final double borderRadius;
  const DualListBox({
    Key? key,
    this.title,
    this.assignTitle,
    this.unAssignTitle,
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
    this.listHeightDesktop = 350,
    this.widgetWidth,
    this.borderRadius = 20,
    this.listHeightMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DualListBoxViewModel()),
      ],
      child: Consumer<DualListBoxViewModel>(builder: (_, consumer, __) {
        consumer.setLists(assignedItems, unassignedItems);
        consumer.isFilterByType = filterByType;
        consumer.isSearchable = searchable;
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
      decoration: BoxDecoration(color: backgroundColor),
      width: widgetWidth ?? MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 0, bottom: 8),
                child: title != null ? _titleWidget(context) : Container(),
              ),
              searchable ? _buildSearchWidget(context, consumer) : Container()
            ],
          ),
          filterByType ? _filterWidget(context, consumer) : Container(),
          Stack(
            alignment: Alignment.center,
            children: [
              _listsWidgetMobile(context, consumer),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _middleButtons(
                    context, consumer, Responsive.isMobile(context)),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildDesktopWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      width: widgetWidth,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 16),
                  child: title != null ? _titleWidget(context) : Container(),
                ),
              ),
              searchable
                  ? Flexible(
                      flex: 4,
                      child: _buildSearchWidget(context, consumer),
                    )
                  : Container()
            ],
          ),
          filterByType ? _filterWidget(context, consumer) : Container(),
          Stack(
            alignment: Alignment.center,
            children: [
              _listsWidget(context, consumer),
              Column(
                children: _middleButtons(
                    context, consumer, Responsive.isMobile(context)),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _middleButtons(
      BuildContext context, DualListBoxViewModel consumer, bool isMobile) {
    return [
      Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(borderRadius / 2),
        child: InkWell(
          onTap: () {
            List<DualListBoxItem> assignedItems =
                consumer.assignSelectedItems(Theme.of(context).primaryColor);
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
            child: RotatedBox(
              quarterTurns: isMobile ? 1 : 0,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 25,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8, width: 8),
      Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(borderRadius / 2),
        child: InkWell(
          onTap: () {
            List<DualListBoxItem> assignedtems =
                consumer.assignAllItems(Theme.of(context).primaryColor);
            if (onAssignAll != null) {
              onAssignAll!(
                  assignedtems, consumer.assignedList, consumer.unAssignedList);
            }
            if (onChange != null) {
              onChange!(consumer.assignedList, consumer.unAssignedList);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: RotatedBox(
              quarterTurns: isMobile ? 1 : 0,
              child: Icon(
                Icons.double_arrow_rounded,
                size: 25,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8, width: 8),
      Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(borderRadius / 2),
        child: InkWell(
          onTap: () {
            List<DualListBoxItem> removedItems =
                consumer.removeSelectedItems(Theme.of(context).primaryColor);
            if (onRemove != null) {
              onRemove!(
                  removedItems, consumer.assignedList, consumer.unAssignedList);
            }
            if (onChange != null) {
              onChange!(consumer.assignedList, consumer.unAssignedList);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: RotatedBox(
              quarterTurns: isMobile ? 1 : 0,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8, width: 8),
      Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(borderRadius / 2),
        child: InkWell(
          onTap: () {
            List<DualListBoxItem> removedItems =
                consumer.removeAllItems(Theme.of(context).primaryColor);
            if (onRemoveAll != null) {
              onRemoveAll!(
                  removedItems, consumer.assignedList, consumer.unAssignedList);
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
              quarterTurns: isMobile ? 3 : 2,
              child: Icon(
                Icons.double_arrow_rounded,
                size: 25,
              ),
            ),
          ),
        ),
      )
    ];
  }

  Widget _listsWidget(BuildContext context, DualListBoxViewModel consumer) {
    return Column(
      children: [
        (unAssignTitle != null || assignTitle != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Text(
                        assignTitle ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Text(
                        unAssignTitle ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        Container(
          height: listHeightDesktop,
          width: widgetWidth,
          child: Row(
            children: [
              Expanded(
                  child: _listWidget(
                      consumer, context, false, Responsive.isMobile(context))),
              Expanded(
                  child: _listWidget(
                      consumer, context, true, Responsive.isMobile(context))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listsWidgetMobile(
      BuildContext context, DualListBoxViewModel consumer) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              (unAssignTitle != null || assignTitle != null)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Text(
                        assignTitle ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  : Container(),
              Container(
                height: listHeightMobile ?? 250,
                child: _listWidget(
                    consumer, context, false, Responsive.isMobile(context)),
              ),
              SizedBox(height: 8),
              Container(
                height: listHeightMobile ?? 250,
                child: _listWidget(
                    consumer, context, true, Responsive.isMobile(context)),
              ),
              (unAssignTitle != null || assignTitle != null)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Text(
                        unAssignTitle ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listWidget(DualListBoxViewModel consumer, BuildContext context,
      bool isAssignedList, bool isMobile) {
    List<DualListBoxItem> list = consumer.unAssignedList;
    if (isAssignedList) {
      list = consumer.assignedList;
    }
    List<DualListBoxItem> filteredList = [];

    return Container(
      margin: EdgeInsets.only(right: 4, left: 4),
      padding: EdgeInsets.only(
          right: isMobile
              ? 16
              : isAssignedList
                  ? 16
                  : 64,
          left: isMobile
              ? 16
              : isAssignedList
                  ? 64
                  : 16,
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
      child: AnimatedList(
        key: isAssignedList
            ? consumer.animatedAssignedListKey
            : consumer.animatedUnAssignedListKey,
        initialItemCount: list.length,
        padding: EdgeInsets.only(
            top: isMobile
                ? isAssignedList
                    ? 16
                    : 0
                : 0,
            bottom: isMobile
                ? isAssignedList
                    ? 0
                    : 16
                : 0),
        itemBuilder: (context, index, animation) {
          return consumer.buildAnimatedListItem(
              isAssignedList, index, backgroundColor, animation);
        },
      ),
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 128),
            child: AutoSizeText(
              title ?? '',
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterWidget(BuildContext context, DualListBoxViewModel consumer) {
    consumer.setTypesList(context);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        runSpacing: 2,
        spacing: 4,
        alignment: WrapAlignment.start,
        children: consumer.buildTypeWidgets(context),
      ),
    );
  }

  _buildSearchWidget(BuildContext context, DualListBoxViewModel consumer) {
    return LenoreTextFormField(
      controller: consumer.searchController,
      label: 'Search',
      onChange: (text) {
        consumer.setSearchList(true);
      },
    );
  }
}
