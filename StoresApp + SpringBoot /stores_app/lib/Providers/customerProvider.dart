import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class customerProvider extends StateNotifier<Customer> {
  // Constructor
  customerProvider() : super(_getInitialcustomer());

  // Get initial customer from Hive or return default
  static Customer _getInitialcustomer() {
    var box = Hive.box('customer');
    if (box.isEmpty) {
      return Customer(
        fullName: 'fullName',
        email: 'email',
        ID: 0,
        password: 'password',
      );
    } else {
      final data = box.get('customer');
      if (data is Customer) {
        return data;
      } else {
        return Customer(
          fullName: 'fullName',
          email: 'email',
          ID: 0,
          password: 'password',
        );
      }
    }
  }

  // Method to reset the state
  void empty() async {
    state = Customer(
      fullName: 'fullName',
      email: 'email',
      ID: 0,
      password: 'password',
    );
    final box = await Hive.openBox('customer');
    box.clear();
  }

  // Method to update full name
  void updateFullName(String newFullName) async {
    state = Customer(
      fullName: newFullName,
      gender: state.gender,
      email: state.email,
      ID: state.ID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
  }

  // Method to update gender
  void updateGender(String? newGender) async {
    state = Customer(
      fullName: state.fullName,
      gender: newGender,
      email: state.email,
      ID: state.ID,
      level: state.level,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
  }

  // Met

  // Method to update level
  void updateLevel(int? newLevel) async {
    state = Customer(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      ID: state.ID,
      level: newLevel,
      password: state.password,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
  }

  // Method to update password
  void updatePassword(String newPassword) async {
    state = Customer(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      ID: state.ID,
      level: state.level,
      password: newPassword,
      imageBytes: state.imageBytes,
    );
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
  }

  // Method to update profile image
  void updateImage(Uint8List? newImageBytes) async {
    state = Customer(
      fullName: state.fullName,
      gender: state.gender,
      email: state.email,
      ID: state.ID,
      level: state.level,
      password: state.password,
      imageBytes: newImageBytes,
    );
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
  }

  // Method to update multiple fields using a map
  void updatecustomer(Customer customer) async {
    state = customer;
    final box = await Hive.openBox('customer');
    await box.put('customer', state);
    print(box.get('customer'));
  }
}

// Provider declaration
final customerProviderr = StateNotifierProvider<customerProvider, Customer>(
  (ref) => customerProvider(),
);
