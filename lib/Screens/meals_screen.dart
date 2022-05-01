import 'package:flutter/material.dart';
import 'package:meal/Helper/meals_list.dart';
import '../Classes/meals_class.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Screens/filters_screen.dart';

List<Meal> favorite = [];

class MealsScreen extends StatefulWidget {
  static const id = 'MealsScreen';

  const MealsScreen({Key? key}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaq = MediaQuery.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    final List<Meal> listOfMeals = mealsList.where((element) {
      return element.categories.contains(args[1]);
    }).toList();
    final List<Meal> listOfMealsFinal = listOfMeals.where(
      (element) {
        if (isGlutenFree && !element.isGlutenFree) return false;
        if (isLactoseFree && !element.isLactoseFree) return false;
        if (isVegan && !element.isVegan) return false;
        if (isVegetarian && !element.isVegetarian) return false;
        return true;
      },
    ).toList();
    // mealsList.where((element) {
    //   return element.categories.contains(args[1]);
    // }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(args[0]),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: mediaq.orientation == Orientation.portrait
              ? const EdgeInsets.symmetric(horizontal: 10)
              : EdgeInsets.symmetric(horizontal: mediaq.size.width * 0.05),
          width: mediaq.size.width,
          height: mediaq.orientation == Orientation.landscape
              ? mediaq.size.height * 0.7
              : mediaq.size.height * 0.8,
          child: listOfMealsFinal.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: mediaq.orientation == Orientation.portrait
                          ? mediaq.size.width * 0.7
                          : mediaq.size.width * 0.4,
                      height: mediaq.orientation == Orientation.landscape
                          ? mediaq.size.height * 0.5
                          : mediaq.size.height * 0.4,
                      fit: BoxFit.fill,
                      image: const AssetImage('assets/nothing.png'),
                    ),
                    const Text(
                      'You have Filtered too Much !',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ],
                )
              : Swiper(
                  indicatorLayout: PageIndicatorLayout.SLIDE,
                  itemBuilder: (context, index) {
                    return Center(
                      child: FlipCard(
                        front: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                listOfMealsFinal[index].imageUrl,
                                // In case of error or bad connection
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    padding: const EdgeInsets.all(30),
                                    color: Colors.purple,
                                    width: mediaq.orientation ==
                                            Orientation.landscape
                                        ? mediaq.size.width * 0.8
                                        : mediaq.size.width * 0.8,
                                    height: mediaq.orientation ==
                                            Orientation.landscape
                                        ? mediaq.size.height * 0.7
                                        : mediaq.size.height * 0.5,
                                    child: Column(
                                      children: const [
                                        Expanded(
                                          child: SpinKitCircle(
                                            duration: Duration(
                                              milliseconds: 1200,
                                            ),
                                            color: Colors.white,
                                            size: 100,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'No or bad connection. But you still can check how to make it',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                width:
                                    mediaq.orientation == Orientation.landscape
                                        ? mediaq.size.width * 0.8
                                        : mediaq.size.width * 0.8,
                                height:
                                    mediaq.orientation == Orientation.landscape
                                        ? mediaq.size.height * 0.7
                                        : mediaq.size.height * 0.5,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: mediaq.orientation ==
                                            Orientation.landscape
                                        ? mediaq.size.width * 0.8
                                        : mediaq.size.width * 0.8,
                                    height: mediaq.orientation ==
                                            Orientation.landscape
                                        ? mediaq.size.height * 0.7
                                        : mediaq.size.height * 0.5,
                                    child: const SpinKitHourGlass(
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(20),
                              width: mediaq.orientation == Orientation.landscape
                                  ? mediaq.size.width * 0.8
                                  : mediaq.size.width * 0.8,
                              // height: mediaq.orientation == Orientation.landscape
                              //     ? mediaq.size.height * 0.7
                              //     : mediaq.size.height * 0.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        listOfMealsFinal[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      for (int i = 0;
                                          i < favorite.length;
                                          i++) {
                                        if (favorite[i] ==
                                            listOfMealsFinal[index]) {
                                          favorite
                                              .remove(listOfMealsFinal[index]);
                                          setState(() {
                                            listOfMealsFinal[index].color =
                                                Colors.grey;
                                          });
                                          return;
                                        }
                                      }
                                      favorite.add(
                                        listOfMealsFinal[index],
                                      );
                                      setState(() {
                                        listOfMealsFinal[index].color =
                                            Colors.yellow;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.star,
                                      color: listOfMealsFinal[index].color,
                                    ),
                                  ),
                                  // Text(
                                  //   listOfMealsFinal[index].complexity.name,
                                  //   style: mediaq.orientation ==
                                  //           Orientation.portrait
                                  //       ? TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 15,
                                  //         )
                                  //       : TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 20,
                                  //           fontWeight: FontWeight.w900,
                                  //         ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        back: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(30),
                          width: mediaq.orientation == Orientation.landscape
                              ? mediaq.size.width * 0.8
                              : mediaq.size.width * 0.8,
                          height: mediaq.orientation == Orientation.landscape
                              ? mediaq.size.height * 0.7
                              : mediaq.size.height * 0.8,
                          child: mediaq.orientation == Orientation.portrait
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Time to make: ${listOfMealsFinal[index].duration} Minutes',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 15,
                                            right: 15,
                                            bottom: 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blueGrey,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              'Ingredients:',
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                              child: ListView(
                                                children: listOfMealsFinal[
                                                        index]
                                                    .ingredients
                                                    .map(
                                                      (e) => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                width: 2,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          e,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 15,
                                            right: 15,
                                            bottom: 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              'Steps:',
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                              child: ListView(
                                                children: listOfMealsFinal[
                                                        index]
                                                    .steps
                                                    .map(
                                                      (e) => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                width: 2,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          e,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Time to make: ${listOfMealsFinal[index].duration} Minutes',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.blueGrey,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        const Text(
                                                          'Ingredients:',
                                                          style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Expanded(
                                                          child: ListView(
                                                            children:
                                                                listOfMealsFinal[
                                                                        index]
                                                                    .ingredients
                                                                    .map(
                                                                      (e) =>
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 10),
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                            bottom:
                                                                                BorderSide(width: 2, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          e,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                    .toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.red,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        const Text(
                                                          'Steps:',
                                                          style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Expanded(
                                                          child: ListView(
                                                            children:
                                                                listOfMealsFinal[
                                                                        index]
                                                                    .steps
                                                                    .map(
                                                                      (e) =>
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 10),
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                            bottom:
                                                                                BorderSide(width: 2, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          e,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                    .toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                  control: const SwiperControl(
                    disableColor: Colors.transparent,
                  ),
                  pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.red,
                      color: Colors.blue,
                    ),
                  ),
                  itemCount: listOfMealsFinal.length,
                  itemWidth: MediaQuery.of(context).size.width * 0.9,
                  itemHeight: MediaQuery.of(context).size.height * 0.8,
                  layout: SwiperLayout.DEFAULT,
                  loop: false,
                ),
        ),
      ),
    );
  }
}
