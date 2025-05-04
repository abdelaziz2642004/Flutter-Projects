import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Providers/AllStoresProvider.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_colors.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/StoreCard.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/Store_app_bar.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  List<Store>? localStores;

  @override
  void initState() {
    super.initState();
    _loadLocalStores();
  }

  void _loadLocalStores() async {
    final box = await Hive.openBox<Store>('storeBox');
    setState(() {
      localStores = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storesAsyncValue = ref.watch(storesProvider);
    final Customer cust = ref.watch(customerProviderr);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            StoreAppBar(text: 'Nearby Stores'),
            storesAsyncValue.when(
              data: (stores) => buildStoreList(stores),
              loading:
                  () => const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffc47c51),
                      ),
                    ),
                  ),
              error: (error, stack) {
                if (localStores != null && localStores!.isNotEmpty) {
                  return buildStoreList(localStores!);
                } else {
                  return buildErrorWidget(error, ref);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable list builder
  Widget buildStoreList(List<Store> stores) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final store = stores[index];
        return StoreCard(
          store: store,
          cardColor: cardColor,
          textColor: textColor,
          secondaryText: secondaryText,
          darkAccent: darkAccent,
        );
      }, childCount: stores.length),
    );
  }

  // Reusable error widget with retry
}

Widget buildErrorWidget(Object error, WidgetRef ref) {
  return SliverFillRemaining(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: darkAccent, size: 48),
          const SizedBox(height: 16),
          Text(
            'Failed to load stores',
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              error.toString(),
              style: TextStyle(color: secondaryText),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () => ref.refresh(storesProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}
