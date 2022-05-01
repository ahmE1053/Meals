import 'package:flutter/material.dart';
import 'package:meal/Classes/category_class.dart';

List<CategoryClass> categoriesList = [
  CategoryClass(
    id: 'c1',
    title: 'Italian',
    color: Colors.purple,
    image: const AssetImage('assets/italian.jpg'),
  ),
  CategoryClass(
    id: 'c2',
    title: 'Quick & Easy',
    color: Colors.red,
    image: const AssetImage('assets/quick.jpg'),
  ),
  CategoryClass(
    id: 'c3',
    title: 'Hamburgers',
    color: Colors.orange,
    image: const AssetImage('assets/hamburgers.jpg'),
  ),
  CategoryClass(
    id: 'c4',
    title: 'German',
    color: Colors.amber,
    image: const AssetImage('assets/german.jpg'),
  ),
  CategoryClass(
    id: 'c5',
    title: 'Light & Lovely',
    color: Colors.blue,
    image: const AssetImage('assets/light.jpg'),
  ),
  CategoryClass(
    id: 'c7',
    title: 'Breakfast',
    color: Colors.lightBlue,
    image: const AssetImage('assets/breakfast.jpg'),
  ),
  CategoryClass(
    id: 'c8',
    title: 'Asian',
    color: Colors.lightGreen,
    image: const AssetImage('assets/asian.jpg'),
  ),
  CategoryClass(
    id: 'c9',
    title: 'French',
    color: Colors.pink,
    image: const AssetImage('assets/french.jpg'),
  ),
  CategoryClass(
    id: 'c10',
    title: 'Summer',
    color: Colors.teal,
    image: const AssetImage('assets/summer.jpg'),
  ),
];
