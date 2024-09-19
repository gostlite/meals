import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeal = [];
  Map<Filter, bool> _filteredMeal = kFilteredMeals;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleFavouriteMealStatus(Meal meal) {
    final tobeAddedMeal = _favouriteMeal.contains(meal);
    if (tobeAddedMeal) {
      setState(() {
        _favouriteMeal.remove(meal);
      });
      _showInfoMessage("The meal has been added to your favorites");
    } else {
      setState(() {
        _favouriteMeal.add(meal);
      });
      _showInfoMessage("This meal has been removed from your favorites");
    }
  }

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
          builder: (ctx) => FiltersScreen(
            currentFilter: _filteredMeal,
          ),
        ),
      );
      setState(() {
        _filteredMeal = result ?? kFilteredMeals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
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
      onToggleFavourite: _toggleFavouriteMealStatus,
      filteredMeals: availableMeals,
    );
    String title = "Categories";

    if (_selectedPageIndex == 1) {
      activeWidget = MealScreen(
        meals: _favouriteMeal,
        onToggleFavourite: _toggleFavouriteMealStatus,
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
