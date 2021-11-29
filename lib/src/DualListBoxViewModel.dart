import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:flutter/material.dart';

class DualListBoxViewModel with ChangeNotifier {
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

  List<DualListBoxItem> removeSelectedItems() {
    List<DualListBoxItem> removedItems = [];
    List<int> removedItemsIndex = [];
    for (var i = 0; i < _assignedList.length; i++) {
      if (_selectedAssignedItems[i]) {
        removedItems.add(_assignedList[i]);
        removedItemsIndex.add(i);
      }
    }

    _assignedList.removeWhere((element) => removedItems.contains(element));

    _unAssignedList.addAll(removedItems);
    setSelectedLists();
    notifyListeners();
    return removedItems;
  }

  List<DualListBoxItem> assignSelectedItems() {
    List<DualListBoxItem> assignedItems = [];
    List<int> assignedItemsIndex = [];
    for (var i = 0; i < _unAssignedList.length; i++) {
      if (_selectedUnAssignedItems[i]) {
        assignedItems.add(_unAssignedList[i]);
        assignedItemsIndex.add(i);
      }
    }
    _unAssignedList.removeWhere((element) => assignedItems.contains(element));

    _assignedList.addAll(assignedItems);
    setSelectedLists();
    notifyListeners();
    return assignedItems;
  }

  List<DualListBoxItem> assignAllItems() {
    List<DualListBoxItem> assignedItems = [];
    assignedItems.addAll(_unAssignedList);
    _assignedList.addAll(_unAssignedList);
    _unAssignedList.removeWhere((element) => true);
    setSelectedLists();
    notifyListeners();
    return assignedItems;
  }

  List<DualListBoxItem> removeAllItems() {
    List<DualListBoxItem> removedItems = [];
    removedItems.addAll(_assignedList);
    _unAssignedList.addAll(_assignedList);
    _assignedList.removeWhere((element) => true);
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
