import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Screens/StoresScreen/StoreService.dart';
import 'package:hive/hive.dart';

final storesProvider = FutureProvider<List<Store>>((ref) async {
  final fetchedStores = await StoreService.fetchStores();
  final box = await Hive.openBox<Store>('storeBox');
  await box.clear();
  for (final store in fetchedStores) {
    await box.add(store);
  }
  return fetchedStores;
});
