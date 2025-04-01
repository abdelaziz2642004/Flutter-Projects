import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_expenses/Models/Expense.dart';
import 'package:my_expenses/Providers/Expenses_provider.dart'; // Assuming this file contains the delete function

class ExpensesItem extends ConsumerStatefulWidget {
  const ExpensesItem({required this.item, super.key});
  final Expense item;

  @override
  ConsumerState<ExpensesItem> createState() => _ExpensesItemState();
}

class _ExpensesItemState extends ConsumerState<ExpensesItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures the card takes full width
      child: Card(
        margin: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 16), // Adds consistent margin
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15), // Rounded corners for better aesthetics
        ),
        elevation: 4, // Adds shadow for a raised effect
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 12), // Adjusts padding for balance
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Aligns content to the start of the column
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () {
                      // Delete the expense using the provider's delete method
                      ref
                          .read(expensesProvider.notifier)
                          .deletee(widget.item, context);
                    },
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete',
                    alignment: Alignment.centerRight,
                    color: const Color.fromARGB(255, 188, 46, 46),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns amount and date info
                children: [
                  Text(
                    'EGP${widget.item.amount.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.green, fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Icon(Iconss[
                          widget.item.category]), // Assuming 'Iconss' exists
                      const SizedBox(width: 8),
                      Text(widget.item.formattedTime),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5), // Space between rows
            ],
          ),
        ),
      ),
    );
  }
}
