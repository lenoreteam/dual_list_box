import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:flutter/material.dart';

import 'DualListBoxItemWidget.dart';

class DualListBoxViewModel with ChangeNotifier {
  final GlobalKey<AnimatedListState> animatedAssignedListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> animatedUnAssignedListKey =
      GlobalKey<AnimatedListState>();
  bool _isFirst = true;
  List<DualListBoxItem> _assignedList = [];
  List<DualListBoxItem> get assignedList => _assignedList;
  set assignedList(List<DualListBoxItem> value) {
    _assignedList = value;
    notifyListeners();
  }

  List<DualListBoxItem> _unAssignedList = [];
  List<DualListBoxItem> get unAssignedList => _unAssignedList;
  set unAssignedList(List<DualListBoxItem> value) {
    _unAssignedList = value;
    notifyListeners();
  }

  List<bool> _selectedAssignedItems = [];
  List<bool> get selectedAssignedItems => _selectedAssignedItems;
  set selectedAssignedItems(List<bool> value) {
    _selectedAssignedItems = value;
    notifyListeners();
  }

  toggleSelectedAssignedItemByIndex(int index) {
    _selectedAssignedItems[index] = !_selectedAssignedItems[index];
    notifyListeners();
  }

  List<bool> _selectedUnAssignedItems = [];
  List<bool> get selectedUnAssignedItems => _selectedUnAssignedItems;
  set selectedUnAssignedItems(List<bool> value) {
    _selectedUnAssignedItems = value;
    notifyListeners();
  }

  toggleSelectedUnAssignedItemByIndex(int index) {
    _selectedUnAssignedItems[index] = !_selectedUnAssignedItems[index];
    notifyListeners();
  }

  Widget buildAnimatedListItem(bool isAssignedList, int index,
      Color backgroundColor, Animation<double> animation,
      {item}) {
    if (item != null) {
      print('returning item');
      return SizeTransition(sizeFactor: animation, child: item);
    }
    List<DualListBoxItem> list = _unAssignedList;
    List<bool> selectedItems = _selectedUnAssignedItems;
    if (isAssignedList) {
      print('it is isAssignedList');
      list = _assignedList;
      selectedItems = _selectedAssignedItems;
    }
    Widget? widget;
    if (selectedItems[index]) {
      widget = list[index].selectedWidget ??
          DualListBoxItemWidget(
            title: list[index].title ?? ' ',
            backgroundColor: backgroundColor,
          );
    } else {
      widget = list[index].widget ??
          DualListBoxItemWidget(title: list[index].title ?? ' ');
    }
    return InkWell(
      onTap: () {
        if (isAssignedList) {
          toggleSelectedAssignedItemByIndex(index);
        } else {
          toggleSelectedUnAssignedItemByIndex(index);
        }
      },
      child: SizeTransition(sizeFactor: animation, child: widget),
    );
  }

  List<DualListBoxItem> removeSelectedItems(Color backgroundColor) {
    List<DualListBoxItem> removedItems = [];
    List<int> removedItemsIndex = [];
    for (var i = 0; i < _assignedList.length; i++) {
      if (_selectedAssignedItems[i]) {
        removedItems.add(_assignedList[i]);
        removedItemsIndex.add(i);
      }
    }

    for (var i = 0; i < removedItems.length; i++) {
      print('removedItemsIndex[i] ${removedItemsIndex[i]}');
      int index =
          _assignedList.indexWhere((element) => element == removedItems[i]);
      _assignedList.removeWhere((element) => element == removedItems[i]);
      animatedAssignedListKey.currentState!.removeItem(
          index,
          (context, animation) => buildAnimatedListItem(
              true, index, backgroundColor, animation,
              item: removedItems[i].widget));
      _unAssignedList.add(removedItems[i]);
      animatedUnAssignedListKey.currentState!
          .insertItem(_unAssignedList.length - 1);
    }
    setSelectedLists();
    notifyListeners();
    return removedItems;
  }

  List<DualListBoxItem> assignSelectedItems(Color backgroundColor) {
    List<DualListBoxItem> assignedItems = [];
    List<int> assignedItemsIndex = [];
    for (var i = 0; i < _unAssignedList.length; i++) {
      if (_selectedUnAssignedItems[i]) {
        assignedItems.add(_unAssignedList[i]);
        assignedItemsIndex.add(i);
      }
    }
    for (var i = 0; i < assignedItems.length; i++) {
      int index =
          _unAssignedList.indexWhere((element) => element == assignedItems[i]);
      _unAssignedList.removeWhere((element) => element == assignedItems[i]);
      animatedUnAssignedListKey.currentState!.removeItem(
          index,
          (context, animation) => buildAnimatedListItem(
              true, index, backgroundColor, animation,
              item: assignedItems[i].widget));
      _assignedList.add(assignedItems[i]);
      animatedAssignedListKey.currentState!.insertItem(assignedList.length - 1);
    }
    setSelectedLists();
    notifyListeners();
    return assignedItems;
  }

  List<DualListBoxItem> assignAllItems(Color backgroundColor) {
    List<DualListBoxItem> assignedItems = [];
    List<int> assignedItemsIndex = [];
    for (var i = 0; i < _unAssignedList.length; i++) {
      assignedItems.add(_unAssignedList[i]);
      assignedItemsIndex.add(i);
    }
    for (var i = 0; i < assignedItems.length; i++) {
      int index =
          _unAssignedList.indexWhere((element) => element == assignedItems[i]);
      _unAssignedList.removeWhere((element) => element == assignedItems[i]);
      animatedUnAssignedListKey.currentState!.removeItem(
          index,
          (context, animation) => buildAnimatedListItem(
              true, index, backgroundColor, animation,
              item: assignedItems[i].widget));
      _assignedList.add(assignedItems[i]);
      animatedAssignedListKey.currentState!.insertItem(assignedList.length - 1);
    }
    setSelectedLists();
    notifyListeners();
    return assignedItems;
  }

  List<DualListBoxItem> removeAllItems(Color backgroundColor) {
    List<DualListBoxItem> removedItems = [];
    List<int> removedItemsIndex = [];
    for (var i = 0; i < _assignedList.length; i++) {
      removedItems.add(_assignedList[i]);
      removedItemsIndex.add(i);
    }

    for (var i = 0; i < removedItems.length; i++) {
      print('removedItemsIndex[i] ${removedItemsIndex[i]}');
      int index =
          _assignedList.indexWhere((element) => element == removedItems[i]);
      _assignedList.removeWhere((element) => element == removedItems[i]);
      animatedAssignedListKey.currentState!.removeItem(
          index,
          (context, animation) => buildAnimatedListItem(
              true, index, backgroundColor, animation,
              item: removedItems[i].widget));
      _unAssignedList.add(removedItems[i]);
      animatedUnAssignedListKey.currentState!
          .insertItem(_unAssignedList.length - 1);
    }
    setSelectedLists();
    notifyListeners();
    return removedItems;
  }

  setLists(List<DualListBoxItem> assignedList,
      List<DualListBoxItem> unAssignedList) {
    if (_isFirst) {
      print('setting lists');
      _assignedList = assignedList;
      _unAssignedList = unAssignedList;
      setSelectedLists();
      _isFirst = false;
    }
  }

  setSelectedLists() {
    _selectedAssignedItems = [];
    _selectedUnAssignedItems = [];
    for (var i = 0; i < _assignedList.length; i++) {
      _selectedAssignedItems.add(false);
    }
    for (var i = 0; i < _unAssignedList.length; i++) {
      _selectedUnAssignedItems.add(false);
    }
  }
}
