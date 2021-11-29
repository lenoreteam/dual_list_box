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
                  right: 16, left: 16, top: 16, bottom: 16),
              child: DualListBox(
                title: 'Demo',
                widgetWidth: 750,
                backgroundColor: Colors.transparent,
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
                    title: 'Apple',
                    type: 'fruit',
                    widget: const DualListBoxItemWidget(
                      title: 'Apple',
                      icon: Icons.restaurant,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Apple',
                      icon: Icons.restaurant,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Orange',
                    type: 'fruit',
                    widget: const DualListBoxItemWidget(
                      title: 'Orange',
                      icon: Icons.restaurant,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Orange',
                      icon: Icons.restaurant,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Corn',
                    type: 'vegetable',
                    widget: const DualListBoxItemWidget(
                      title: 'Corn',
                      icon: Icons.restaurant_menu,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Corn',
                      icon: Icons.restaurant_menu,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
                unassignedItems: [
                  DualListBoxItem(
                    title: 'Banana',
                    type: 'fruit',
                    widget: const DualListBoxItemWidget(
                      title: 'Banana',
                      icon: Icons.restaurant,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Banana',
                      icon: Icons.restaurant,
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  DualListBoxItem(
                    title: 'Carrot',
                    type: 'vegetable',
                    widget: const DualListBoxItemWidget(
                      title: 'Carrot',
                      icon: Icons.restaurant_menu,
                    ),
                    selectedWidget: DualListBoxItemWidget(
                      title: 'Carrot',
                      icon: Icons.restaurant_menu,
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
