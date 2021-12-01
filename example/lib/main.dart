import 'package:dual_list_box/dual_list_box.dart';
import 'package:flutter/material.dart';
import 'package:lenore_ui/lenore_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dual List Box',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Dual List Box'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Card(
            elevation: 11,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 8, bottom: 16),
              child: DualListBox(
                title: 'Assign User To Developers Group',
                assignTitle: 'Unassigned Users/Groups',
                unAssignTitle: 'Assigned Users/Groups',
                widgetWidth: 750,
                backgroundColor: Colors.transparent,
                filterByType: true,
                onRemove: (newlyRemovedItems, assignedList, unAssignedList) {
                  print('removedItems are: $newlyRemovedItems');
                },
                onRemoveAll: (newlyRemovedItems, assignedList, unAssignedList) {
                  print('All removedItems are: $newlyRemovedItems');
                },
                onAssign: (newlyAssignedItems, assignedList, unAssignedList) {
                  print('assignedItems are: $newlyAssignedItems');
                },
                onAssignAll:
                    (newlyAssignedItems, assignedList, unAssignedList) {
                  print('All assignedItems are: $newlyAssignedItems');
                },
                assignedItems: [
                  DualListBoxItem(
                    title: 'John',
                    type: 'user',
                    widget: const DualListBoxItemWidget(
                      title: 'John',
                      icon: Icons.person,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'John',
                      icon: Icons.person,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Mario',
                    type: 'user',
                    widget: const DualListBoxItemWidget(
                      title: 'Mario',
                      icon: Icons.person,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Mario',
                      icon: Icons.person,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Java Devs',
                    type: 'group',
                    widget: const DualListBoxItemWidget(
                      title: 'Java Devs',
                      icon: Icons.group,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Java Devs',
                      icon: Icons.group,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
                unassignedItems: [
                  DualListBoxItem(
                    title: 'Yoshi',
                    type: 'user',
                    widget: const DualListBoxItemWidget(
                      title: 'Yoshi',
                      icon: Icons.person,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Yoshi',
                      icon: Icons.person,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Maintenance',
                    type: 'group',
                    widget: const DualListBoxItemWidget(
                      title: 'Maintenance',
                      icon: Icons.group,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Maintenance',
                      icon: Icons.group,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
