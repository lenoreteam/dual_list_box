import 'package:dual_list_box/src/DualListBoxItem.dart';
import 'package:flutter/material.dart';

class DualListBoxViewModel with ChangeNotifier {
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

  seperateLists(List<DualListBoxItem> allList) {
    _assignedList = [];
    _unAssignedList = [];
    for (var i = 0; i < allList.length; i++) {
      if (allList[i].isAssigned ?? false) {
        _assignedList.add(allList[i]);
        _selectedAssignedItems.add(false);
      } else {
        _unAssignedList.add(allList[i]);
        _selectedUnAssignedItems.add(false);
      }
    }
  }
}
