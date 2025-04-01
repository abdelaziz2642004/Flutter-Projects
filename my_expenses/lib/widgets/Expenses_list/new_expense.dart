import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_expenses/Models/Expense.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_expenses/Providers/Expenses_provider.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key});

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  bool is_loading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  Category? _cat;

  bool _categoryValid = true;
  bool _titleValid = true;
  bool _amountValid = true;
  bool _dateValid = true;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _showDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1924),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = formatter.format(picked);
        _dateValid = true; // Date is valid once selected
      });
    } else {
      if (_selectedDate == null) {
        setState(() {
          _dateValid = false; // No date selected
        });
      }
    }
  }

  void _validateTitle(String value) {
    setState(() {
      _titleValid = value.trim().isNotEmpty;
    });
  }

  void _validateAmount(String value) {
    final val = double.tryParse(value);
    setState(() {
      _amountValid = val != null;
    });
  }

  void _validateCategory(Category? value) {
    setState(() {
      _cat = value;
      _categoryValid = _cat != null;
    });
  }

  void _validateDate() {
    setState(() {
      _dateValid = _selectedDate != null;
    });
  }

  void _save() async {
    _validateTitle(_titleController.text);
    _validateAmount(_amountController.text);
    _validateCategory(_cat);
    _validateDate();
    setState(() {
      is_loading = true;
    });

    bool valid = _titleValid && _amountValid && _categoryValid && _dateValid;

    if (valid) {
      // Extract values
      final title = _titleController.text;
      final amount =
          double.parse(_amountController.text); // Assuming amount is a double
      final time = _selectedDate!;
      final cat = _cat!;
      final url = Uri.https('expenses-app-3cf00-default-rtdb.firebaseio.com',
          'expenses-app.json');
      // print(DateTime.parse(time.toString()));

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            't': title, //fine
            'a': amount, //fine
            'time': time.toString(), //not
            'cat': cat.name
          }));
      // print(response.statusCode);

      if (response.statusCode >= 400) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to add data. Try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        setState(() {
          is_loading = false;
        });
        return; // Don't proceed if the request fails.
      }
      // Pass values to the add function
      final data = json.decode(response.body);
      ref.read(expensesProvider.notifier).add(
          title: title, amount: amount, date: time, cat: cat, id: data['name']);
      if (!(context.mounted)) return;
//else
      Navigator.pop(context);
    } else {
      setState(() {
        is_loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    const SizedBox(height: 20);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title TextField
            TextField(
              maxLength: 50,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _titleValid ? Colors.grey : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _titleValid ? Colors.blue : Colors.red,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
              onChanged: _validateTitle,
            ),
            const SizedBox(height: 7.0),

            // Amount and Category Selection
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      prefixText: 'EGP ',
                      labelText: 'Amount',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _amountValid ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _amountValid ? Colors.blue : Colors.red,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                    ),
                    onChanged: _validateAmount,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<Category>(
                    value: _cat,
                    items: Category.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Row(children: [
                              Icon(Iconss[e]),
                              SizedBox(
                                width: 5,
                              ),
                              Text(e.name.toUpperCase())
                            ])))
                        .toList(),
                    onChanged: (item) {
                      _validateCategory(item);
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _categoryValid ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _categoryValid ? Colors.grey : Colors.red,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    hint: const Text(
                        "Select Category"), // Optional hint when no value is selected
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),

            // Date Selection

// Date Selection
            Center(
              child: GestureDetector(
                onTap: _showDate, // Makes the entire container clickable
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _dateValid ? Colors.grey : Colors.red,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                      Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : formatter.format(_selectedDate!),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 86, 86, 86),
                          fontWeight:
                              _dateValid ? FontWeight.normal : FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: is_loading
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Exit Window'),
                  ),
                  const SizedBox(width: 16.0), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: is_loading ? null : _save,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: is_loading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
