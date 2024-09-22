import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/screens/category_screen.dart';
// import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/filter_switch_tile.dart';
// import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeState = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(onTapIdentifier: (String identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == "meals") {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: Column(
        children: [
          FilterSwitchTile(
              filterSet: activeState[Filter.glutenFree]!,
              switchOnChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
              title: "Glutten"),
          FilterSwitchTile(
              filterSet: activeState[Filter.lactoseFree]!,
              switchOnChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
              },
              title: "Lactose"),
          FilterSwitchTile(
              filterSet: activeState[Filter.vegetarian]!,
              switchOnChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
              },
              title: "Vegetable"),
          FilterSwitchTile(
              filterSet: activeState[Filter.vegan]!,
              switchOnChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
              },
              title: "Vegan")
        ],
      ),
    );
  }
}
