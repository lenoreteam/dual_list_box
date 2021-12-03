import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:flutter/material.dart';

import 'DualListBoxTypeItem.dart';
import 'DualListBoxItemWidget.dart';
import 'DualListBoxTypeWidget.dart';

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

  List<DualListBoxItem> _assignedListInit = [];
  List<DualListBoxItem> get assignedListInit => _assignedListInit;
  set assignedListInit(List<DualListBoxItem> value) {
    _assignedListInit = value;
    notifyListeners();
  }

  List<DualListBoxItem> _unAssignedListInit = [];
  List<DualListBoxItem> get unAssignedListInit => _unAssignedListInit;
  set unAssignedListInit(List<DualListBoxItem> value) {
    _unAssignedListInit = value;
    notifyListeners();
  }

  List<DualListBoxTypeItem> _types = [];
  List<DualListBoxTypeItem> get types => _types;
  set types(List<DualListBoxTypeItem> value) {
    _types = value;
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

  List<bool> _filteredAssignedItems = [];
  List<bool> get filteredAssignedItems => _filteredAssignedItems;
  set filteredAssignedItems(List<bool> value) {
    _filteredAssignedItems = value;
    notifyListeners();
  }

  togglefilteredAssignedItemByIndex(int index) {
    _filteredAssignedItems[index] = !_filteredAssignedItems[index];
    notifyListeners();
  }

  List<bool> _filteredUnAssignedItems = [];
  List<bool> get filteredUnAssignedItems => _filteredUnAssignedItems;
  set filteredUnAssignedItems(List<bool> value) {
    _filteredUnAssignedItems = value;
    notifyListeners();
  }

  togglefilteredUnAssignedItemByIndex(int index) {
    _filteredUnAssignedItems[index] = !_filteredUnAssignedItems[index];
    notifyListeners();
  }

  Widget buildAnimatedListItem(bool isAssignedList, int index,
      Color backgroundColor, Animation<double> animation,
      {item}) {
    if (item != null) {
      return SizeTransition(sizeFactor: animation, child: item);
    }
    List<DualListBoxItem> list = _unAssignedList;
    List<bool> selectedItems = _selectedUnAssignedItems;

    bool _isAllTypesSelectedOrUnselected = isAllTypesSelectedOrUnselected();
    if (!_isAllTypesSelectedOrUnselected) {
      setFilteredList();
    }
    List<bool> filteredItems = _filteredUnAssignedItems;
    if (isAssignedList) {
      list = _assignedList;
      filteredItems = _filteredAssignedItems;
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
    if (!_isAllTypesSelectedOrUnselected) {
      if (!filteredItems[index]) {
        return Container();
      }
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
      _assignedListInit = assignedList;
      _unAssignedListInit = unAssignedList;
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

  void setTypesList(BuildContext context) {
    List<DualListBoxItem> allList = [];
    allList.addAll(_assignedList);
    allList.addAll(_unAssignedList);
    for (var i = 0; i < allList.length; i++) {
      bool _containsType = false;
      if (allList[i].type != null) {
        for (var type in _types) {
          if (type.name == allList[i].type) {
            _containsType = true;
            break;
          }
        }
        if (!_containsType) {
          _types.add(DualListBoxTypeItem(
              name: allList[i].type ?? '', isSelected: false));
        }
      }
    }
    print('types = $_types');
  }

  List<Widget> buildTypeWidgets(BuildContext context) {
    List<Widget> widgets = [];

    for (var i = 0; i < _types.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            _types[i].isSelected = !_types[i].isSelected;
            notifyListeners();
          },
          child: DualListBoxTypeWidget(
            name: _types[i].name,
            isSelected: _types[i].isSelected,
          ),
        ),
      );
    }
    return widgets;
  }

  setFilteredList() {
    _filteredAssignedItems = [];
    _filteredUnAssignedItems = [];

    for (var item in _assignedList) {
      for (var type in _types) {
        if (type.name == item.type) {
          if (type.isSelected) {
            _filteredAssignedItems.add(true);
          } else {
            _filteredAssignedItems.add(false);
          }
        }
      }
    }

    for (var item in _unAssignedList) {
      for (var type in _types) {
        print('item type = ${item.type}');
        print('type = ${type.name}');
        print('type.isSelected = ${type.isSelected}');
        if (type.name == item.type) {
          if (type.isSelected) {
            _filteredUnAssignedItems.add(true);
          } else {
            _filteredUnAssignedItems.add(false);
          }
        }
      }
    }
    print('_filteredAssignedItems = $_filteredAssignedItems');
    print('_filteredUnAssignedItems = $_filteredUnAssignedItems');
    // notifyListeners();
  }

  bool isAllTypesSelectedOrUnselected() {
    bool isAllSelected = true;
    bool isAllUnSelected = true;
    for (var type in _types) {
      if (type.isSelected) {
        isAllUnSelected = false;
      }
      if (!type.isSelected) {
        isAllSelected = false;
      }
      if (!isAllSelected && !isAllUnSelected) {
        break;
      }
    }
    print('isAllSelectedOrUnselected = ${isAllSelected || isAllUnSelected}');
    return isAllSelected || isAllUnSelected;
  }
}
