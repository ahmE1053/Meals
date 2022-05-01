import 'package:flutter/material.dart';
import 'package:meal/Screens/filters_screen.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({Key? key}) : super(key: key);
  static const id = 'NaviScreen';
  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {
  PageController? _pageController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Drawer buildDrawer() {
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
              tileColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusColor: Colors.purple.withOpacity(0.5),
              style: ListTileStyle.drawer,
              hoverColor: Colors.purple.withOpacity(0.5),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              style: ListTileStyle.drawer,
              title: const Text('Filters'),
              onTap: () {
                Navigator.of(context).pushNamed(FiltersScreen.id);
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
        centerTitle: true,
        title: const Text('Mealio'),
      ),
      drawer: buildDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          CategoriesScreen(),
          FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              _pageController?.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
