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
                onRemove: (removedItems) {
                  print('removedItems are: $removedItems');
                },
                onRemoveAll: (removedItems) {
                  print('All removedItems are: $removedItems');
                },
                onAssign: (assignedItems) {
                  print('assignedItems are: $assignedItems');
                },
                onAssignAll: (assignedItems) {
                  print('All assignedItems are: $assignedItems');
                },
                items: [
                  DualListBoxItem(
                    title: 'Apple',
                    isAssigned: true,
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
                    isAssigned: false,
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
                    title: 'Banana',
                    isAssigned: false,
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
                    isAssigned: false,
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
                  DualListBoxItem(
                    title: 'Corn',
                    isAssigned: true,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
