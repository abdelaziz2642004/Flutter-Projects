import 'package:store_app/Models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/app.dart';

const String baseUrl =
    "http://192.168.1.104:8080"; // if windows , ipconfig , and get your computer's ip and put it here
// and if ubuntu or linux , ip a , next to inet :D

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CustomerAdapter());
  await Hive.openBox('customer');
  Hive.registerAdapter(StoreAdapter());
  await Hive.openBox<List>('storesBox');
  runApp(const ProviderScope(child: MaterialApp(home: App())));
}
