import 'package:flutter/material.dart';

import 'navigation_main_screen.dart';

bool isGlutenFree = false;
bool isLactoseFree = false;
bool isVegan = false;
bool isVegetarian = false;

class FiltersScreen extends StatelessWidget {
  static const id = 'Filters Screen';

  const FiltersScreen({Key? key}) : super(key: key);
  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.purple,
            height: 200,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Mealio',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusColor: Colors.purple.withOpacity(0.5),
              style: ListTileStyle.drawer,
              hoverColor: Colors.purple.withOpacity(0.5),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(NaviScreen.id);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
              tileColor: Colors.grey,
              style: ListTileStyle.drawer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Filters'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(FiltersScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      drawer: buildDrawer(context),
      body: const SafeArea(
        child: SwitchTile(),
      ),
    );
  }
}

class SwitchTile extends StatefulWidget {
  const SwitchTile({Key? key}) : super(key: key);

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
            title: const Text('Is Gluten Free?'),
            value: isGlutenFree,
            onChanged: (value) {
              setState(() {
                isGlutenFree = value;
              });
            }),
        SwitchListTile(
            title: const Text('Is Lactose Free?'),
            value: isLactoseFree,
            onChanged: (value) {
              setState(() {
                isLactoseFree = value;
              });
            }),
        SwitchListTile(
            title: const Text('Is Vegan?'),
            value: isVegan,
            onChanged: (value) {
              setState(() {
                isVegan = value;
              });
            }),
        SwitchListTile(
            title: const Text('Is Vegetarian?'),
            value: isVegetarian,
            onChanged: (value) {
              setState(() {
                isVegetarian = value;
              });
            }),
      ],
    );
  }
}
