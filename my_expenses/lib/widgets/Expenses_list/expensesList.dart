import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_expenses/Models/Expense.dart';
import 'package:my_expenses/Providers/Expenses_provider.dart';
import 'package:my_expenses/widgets/Expenses_list/ExpensesItem.dart';

class Expenseslist extends ConsumerStatefulWidget {
  const Expenseslist({super.key});

  @override
  ConsumerState<Expenseslist> createState() => _ExpenseslistState();
}

class _ExpenseslistState extends ConsumerState<Expenseslist> {
  @override
  Widget build(BuildContext context) {
    final currExps =
        ref.watch(expensesProvider); // Watch to update when state changes

    return ListView.builder(
      itemCount: currExps.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(currExps[index].id), // Use a unique key like an ID
        background: Card(
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
        ),
        onDismissed: (direction) {
          // Perform the delete action
          ref.read(expensesProvider.notifier).deletee(currExps[index], context);
          setState(() {});
        },
        child: ExpensesItem(
          item: currExps[index],
        ),
      ),
    );
  }
}
