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

  seperateLists(List<DualListBoxItem> allList) {
    _assignedList = [];
    _unAssignedList = [];
    for (var i = 0; i < allList.length; i++) {
      if (allList[i].isSelected ?? false) {
        _assignedList.add(allList[i]);
      } else {
        _unAssignedList.add(allList[i]);
      }
    }
  }
}