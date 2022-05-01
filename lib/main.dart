import 'package:flutter/material.dart';
import 'Screens/categories_screen.dart';
import 'Screens/meals_screen.dart';
import './Screens/navigation_main_screen.dart';
import './Screens/filters_screen.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: NaviScreen.id,
        routes: {
          NaviScreen.id: (context) => const NaviScreen(),
          CategoriesScreen.id: (context) => const CategoriesScreen(),
          MealsScreen.id: (context) => const MealsScreen(),
          FiltersScreen.id: (context) => const FiltersScreen(),
        },
      ),
    );
