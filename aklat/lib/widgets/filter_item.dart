import 'package:Aklatoo/Provider/filter_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterItem extends ConsumerStatefulWidget {
  const FilterItem({
    super.key,
    required this.filter,
    required this.title,
    required this.midtitle,
  });

  final String title;
  final String midtitle;
  final Filters filter;

  @override
  ConsumerState<FilterItem> createState() {
    return _FilterItemState();
  }
}

class _FilterItemState extends ConsumerState<FilterItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = ref.read(filterProvider)[widget.filter]!;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _isChecked,
      onChanged: (isChecked) {
        setState(() {
          _isChecked = isChecked;
        });
        ref.watch(filterProvider.notifier).setFilter(widget.filter, isChecked);
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(),
      ),
      subtitle: Text(
        'only include ${widget.midtitle} meals',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(),
      ),
      // activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
