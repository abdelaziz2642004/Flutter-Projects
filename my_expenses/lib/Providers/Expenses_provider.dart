import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_expenses/Models/Expense.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

class ExpensesProvider extends StateNotifier<List<Expense>> {
  ExpensesProvider() : super([]);

  void add({
    required String title,
    required double amount,
    required DateTime date,
    required Category cat,
    required String id,
  }) {
    state = [
      ...state,
      Expense(
        id: id,
        amount: amount,
        title: title,
        date: date,
        category: cat,
      )
    ];
  }

  void deletee(Expense sth, BuildContext context) async {
    final index = state.indexOf(sth);

    // Temporarily remove the item from the list and show a SnackBar
    final removedExpense = sth;
    state = state.where((element) => element.id != sth.id).toList();

    // Cancel any previous SnackBar to avoid delays
    ScaffoldMessenger.of(context).clearSnackBars();

    bool canDelete = true;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Reinsert the deleted item if "Undo" is pressed
          state = [
            ...state.sublist(0, index),
            removedExpense,
            ...state.sublist(index)
          ];
          canDelete = false;
        },
      ),
    ));

    // Skip the 3-second delay if a new deletion is triggered during this time
    await Future.delayed(const Duration(seconds: 4));
    if (!canDelete) return;

    // Delete from database after delay
    final url = Uri.https('expenses-app-3cf00-default-rtdb.firebaseio.com',
        'expenses-app/${sth.id}.json');
    final response = await http.delete(url);

    // Handle errors by restoring the deleted item if the request fails
    if (response.statusCode >= 400) {
      // Reinsert the deleted item if the delete request fails
      state = [
        ...state.sublist(0, index),
        removedExpense,
        ...state.sublist(index)
      ];
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete expense.')),
      );
    }
  }
}

final expensesProvider = StateNotifierProvider<ExpensesProvider, List<Expense>>(
    (ref) => ExpensesProvider());
