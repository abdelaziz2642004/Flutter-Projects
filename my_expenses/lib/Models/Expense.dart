// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // run flutter pub add intl

final formatter = DateFormat.yMd();
// "flutter pub add uuid " run this command to add uuid which is a unique id

enum Category {
  food,
  travel,
  freeTime,
  work,
  courses,
  fitness,
  shopping,
  health,
  finance,
  entertainment,
  home,
  social,
  transport,
  technology,
  personalCare,
  education,
  events,
  gifts
}

final Iconss = {
  Category.food: Icons.fastfood, // Represents food
  Category.travel: Icons.airplanemode_active, // Represents travel
  Category.freeTime: Icons.movie, // Represents free time or entertainment
  Category.courses: Icons.school, // Represents courses or education
  Category.work: Icons.work, // Represents work
  Category.fitness: Icons.fitness_center, // Represents fitness or exercise
  Category.shopping: Icons.shopping_cart, // Represents shopping
  Category.health: Icons.local_hospital, // Represents health or medical
  Category.finance: Icons.attach_money, // Represents finance or money
  Category.entertainment: Icons.music_note, // Represents entertainment or music
  Category.home: Icons.home, // Represents home or living
  Category.social: Icons.group, // Represents social activities or gatherings
  Category.transport: Icons.directions_car, // Represents transport or commuting
  Category.technology: Icons.computer, // Represents technology or gadgets
  Category.personalCare: Icons.brush, // Represents personal care or grooming
  Category.education: Icons.book, // Represents education or learning
  Category.events: Icons.event, // Represents events or occasions
  Category.gifts: Icons.card_giftcard // Represents gifts or presents
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category,
      required this.id});

  final String id; // unique id , use  the uuid library
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedTime {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

// bucket for each category for the chart
class ExpenseBucket {
  // Alternative Constructor
  //just like this
  //margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.cat)
      : expenses =
            allExpenses.where((expense) => expense.category == cat).toList();

  const ExpenseBucket({required this.cat, required this.expenses});
  final Category cat;
  final List<Expense> expenses;
  double get total {
    double sum = 0;
    for (final item in expenses) {
      sum += item.amount;
    }
    return sum;
  }
}

final Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.freeTime: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
  Category.courses: Icons.school,
};
