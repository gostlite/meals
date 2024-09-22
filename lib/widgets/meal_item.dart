import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(
      {super.key, required this.meal, required this.navToMealDetail});
  final Meal meal;
  final void Function() navToMealDetail;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge, // enforce the parent shape
      elevation: 8,
      child: InkWell(
        onTap: navToMealDetail,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, // make sure the images fit
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, // cuts of the text and adding ... to it
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      MealItemTrait(
                          icon: Icons.schedule, label: '${meal.duration} mins'),
                      const SizedBox(
                        width: 12,
                      ),
                      MealItemTrait(icon: Icons.work, label: complexityText),
                      const SizedBox(
                        width: 12,
                      ),
                      MealItemTrait(
                          icon: Icons.attach_money, label: affordabilityText),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
