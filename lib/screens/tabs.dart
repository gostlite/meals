import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorite_meal_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const kFilteredMeals = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _filteredMeal = kFilteredMeals;

  // void _showInfoMessage(String message) {

  // }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      setState(() {
        _filteredMeal = result ?? kFilteredMeals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final availableMeals = meals.where((meal) {
      if (_filteredMeal[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filteredMeal[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filteredMeal[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_filteredMeal[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeWidget = CategoryScreen(
      filteredMeals: availableMeals,
    );
    String title = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activeWidget = MealScreen(
        meals: favoriteMeal,
      );
      title = "Your favourite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        onTapIdentifier: _setScreen,
      ),
      body: activeWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourite'),
        ],
        onTap: selectPage,
      ),
    );
  }
}
