import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_expenses/Models/Expense.dart';
import 'package:my_expenses/Providers/Expenses_provider.dart';
import 'package:my_expenses/widgets/Chart/chartbar.dart';

class Chart extends ConsumerWidget {
  const Chart({super.key});

  // Function to create buckets dynamically based on the expenses list
  List<ExpenseBucket> createBuckets(List<Expense> expenses) {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.freeTime),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.courses),
    ];
  }

  // Calculate the maximum total expense in any category
  double getMaxTotalExpense(List<ExpenseBucket> buckets) {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.total > maxTotalExpense) {
        maxTotalExpense = bucket.total;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the expensesProvider to get the current list of expenses
    final expenses = ref.watch(expensesProvider);

    // Create the buckets based on the current expenses
    final buckets = createBuckets(expenses);

    // Get the maximum total expense to scale the chart bars
    final maxTotalExpense = getMaxTotalExpense(buckets);

    // Check if dark mode is enabled
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket
                    in buckets) // Loop through buckets to create chart bars
                  ChartBar(
                    fill: bucket.total == 0
                        ? 0
                        : bucket.total /
                            maxTotalExpense, // Scale based on max total
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[
                            bucket.cat], // Display icon for each category
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
