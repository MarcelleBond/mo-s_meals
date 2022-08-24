import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class CategorymealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  List<Meal> availableMeals;

  CategorymealsScreen(this.availableMeals);
  
  @override
  State<CategorymealsScreen> createState() => _CategorymealsScreenState();
}

class _CategorymealsScreenState extends State<CategorymealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String categoryId = routeArg["id"];
      categoryTitle = routeArg['title'];
      displayedMeals = widget.availableMeals
          .where(
            (element) => element.categories.contains(categoryId),
          )
          .toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
