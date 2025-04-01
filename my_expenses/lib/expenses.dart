import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_expenses/Models/Expense.dart';
import 'package:my_expenses/widgets/Chart/chart.dart';
import 'package:my_expenses/widgets/Expenses_list/expensesList.dart';
import 'package:my_expenses/widgets/Expenses_list/new_expense.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_expenses/Providers/Expenses_provider.dart';

class Expenses extends ConsumerStatefulWidget {
  const Expenses({super.key});

  @override
  ConsumerState<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends ConsumerState<Expenses> {
  bool is_loading = true;
  @override
  void initState() {
    super.initState();
    _load();
  }

  String _error = 'No expenses found, add some!';
  void _load() async {
    final url = Uri.https(
        'expenses-app-3cf00-default-rtdb.firebaseio.com', 'expenses-app.json');
    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        setState(() {
          _error = "No expenses found, add some!";
          is_loading = false;
        });
        return;
      }

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch the data , please try again later <3";
          is_loading = false;
          return;
        });
      }

      final data = json.decode(response.body);

      for (final item in data.entries) {
        final Category category =
            Category.values.firstWhere((cat) => cat.name == item.value['cat']);
        ref.read(expensesProvider.notifier).add(
            id: item.key,
            amount: item.value['a'], // double (number in database )
            title: item.value['t'], // string okay
            date: DateTime.now(), // converts the string to a DateTime object
            cat: category);
      }
      setState(() {});
    } catch (error) {
      print("Error: $error");
      setState(() {
        _error = "Something went wrong";
        is_loading = false;
      });
    }
    setState(() {
      is_loading = false;
    });
  }

  void _0verLay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: NewExpense(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Use ref.watch here to listen for state changes
    final currentExpenses = ref.watch(expensesProvider);
    Widget maincontent = Center(
      child: Text(_error),
    );
    // needs to be watch and not read because we want this to be rebuilt everytime the ref changes data
    if (is_loading) {
      maincontent = const Center(child: CircularProgressIndicator());
    }

    if (currentExpenses.isNotEmpty) {
      maincontent = const Expenseslist();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses!"),
        actions: [
          IconButton(onPressed: _0verLay, icon: const Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                const Chart(),
                Expanded(child: maincontent),
              ],
            )
          : Row(
              children: [
                const Expanded(child: Chart()),
                Expanded(child: maincontent),
              ],
            ),
    );
  }
}
