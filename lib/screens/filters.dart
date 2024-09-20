import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/screens/category_screen.dart';
// import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/filter_switch_tile.dart';
// import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _gluttenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegeterianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filterProvider);
    _gluttenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegeterianFreeFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFreeFilterSet = activeFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
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
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) async {
          if (!didPop) return;
          ref.read(filterProvider.notifier).setFilters({
            Filter.glutenFree: _gluttenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegeterianFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
          });
          // Navigator.of(context).pop();
        },
        child: Column(
          children: [
            FilterSwitchTile(
                filterSet: _gluttenFreeFilterSet,
                switchOnChanged: (isChecked) {
                  setState(() {
                    _gluttenFreeFilterSet = isChecked;
                  });
                },
                title: "Glutten"),
            FilterSwitchTile(
                filterSet: _lactoseFreeFilterSet,
                switchOnChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeFilterSet = isChecked;
                  });
                },
                title: "Lactose"),
            FilterSwitchTile(
                filterSet: _vegeterianFreeFilterSet,
                switchOnChanged: (isChecked) {
                  setState(() {
                    _vegeterianFreeFilterSet = isChecked;
                  });
                },
                title: "Vegetable"),
            FilterSwitchTile(
                filterSet: _veganFreeFilterSet,
                switchOnChanged: (isChecked) {
                  setState(() {
                    _veganFreeFilterSet = isChecked;
                  });
                },
                title: "Vegan")
          ],
        ),
      ),
    );
  }
}
