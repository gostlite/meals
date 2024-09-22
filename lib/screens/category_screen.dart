import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.filteredMeals});

  final List<Meal> filteredMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  void _selectedCategory(BuildContext context, Category category) {
    final specificMeal = widget.filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: specificMeal,
          title: category.title,
        ),
      ),
    );
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            //  availableCategories
            //     .map((category) => CategoryGridItem(category: category))
            //     .toList(),

            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectedCategory(context, category);
                },
              )
          ],
        ),
        builder: (ctx, widget) => Padding(
            padding:
                EdgeInsets.only(top: 100 - _animationController.value * 100),
            child: widget));
  }
}
