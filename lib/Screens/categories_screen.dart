import 'package:flutter/material.dart';
import 'package:meal/Screens/meals_screen.dart';
import '../Helper/category_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const id = 'CategoriesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4),
          children: categoriesList
              .map(
                (e) => LayoutBuilder(
                  builder: (context, cons) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MealsScreen.id,
                        arguments: [e.title, e.id],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            height: cons.maxHeight,
                            width: cons.maxWidth,
                            fit: BoxFit.fill,
                            image: e.image,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: e.color.withOpacity(0.8),
                            // gradient: LinearGradient(
                            //   colors: [
                            // e.color.withOpacity(0.1),
                            // e.color.withOpacity(0.2),
                            // e.color.withOpacity(0.3),
                            //     e.color,
                            //     e.color,
                            //   ],
                            //   begin: Alignment.bottomRight,
                            //   end: Alignment.topLeft,
                            // ),
                          ),
                          child: FittedBox(
                            child: Text(
                              e.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: cons.maxWidth * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
