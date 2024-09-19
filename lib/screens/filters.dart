import 'package:flutter/material.dart';
// import 'package:meals/screens/category_screen.dart';
// import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/filter_switch_tile.dart';
// import 'package:meals/widgets/main_drawer.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilter});
  final Map<Filter, bool> currentFilter;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluttenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegeterianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    _gluttenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _vegeterianFreeFilterSet = widget.currentFilter[Filter.vegetarian]!;
    _veganFreeFilterSet = widget.currentFilter[Filter.vegan]!;
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
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _gluttenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegeterianFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
          });
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
