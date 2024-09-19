import 'package:flutter/material.dart';

class FilterSwitchTile extends StatelessWidget {
  const FilterSwitchTile(
      {super.key,
      required this.filterSet,
      required this.switchOnChanged,
      required this.title});
  final String title;
  final bool filterSet;
  final void Function(bool val) switchOnChanged;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: filterSet,
      onChanged: switchOnChanged,
      title: Text(
        "$title-free",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        "only include ${title.toLowerCase()} free meals",
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
