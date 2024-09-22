import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });
  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    //do not mutate the state directly
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealasProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final filteredMeals = ref.watch(filterProvider);
  return meals.where((meal) {
    if (filteredMeals[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filteredMeals[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filteredMeals[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filteredMeals[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
