import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Providers/AllStoresProvider.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Providers/favoriteStoresProvider.dart';
import 'package:store_app/Screens/FavoriteScreen/HelpingWidgets/StoreCard.dart';
import 'package:store_app/Screens/FavoriteScreen/favoriteService.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/Store_app_bar.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/colors.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  late FavoriteService favoriteService;

  @override
  void initState() {
    super.initState();
    favoriteService = FavoriteService();
    final customer = ref.read(customerProviderr);
    favoriteService
      ..fullName = customer.fullName
      ..ID = customer.ID
      ..email = customer.email;
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.read(customerProviderr);
    final favoriteAsync = ref.watch(favoriteStoresProvider(customer.ID));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StoreAppBar(text: 'Favorite Stores'),
          SliverToBoxAdapter(
            child: favoriteAsync.when(
              data:
                  (stores) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stores.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        final store = stores[index];
                        return StoreCardFavorite(
                          rebuild: () {
                            setState(() {});
                          },
                          store: store,
                          favoriteService: favoriteService,
                        );
                      },
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => buildErrorWidget(error, ref),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildErrorWidget(Object error, WidgetRef ref) {
  return Center(
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
          onPressed: () {
            final Customer customer = ref.read(customerProviderr);
            ref
                .read(favoriteStoresProvider(customer.ID).notifier)
                .fetchFavorites();

            ref.refresh(storesProvider);

            // Future.delayed(Duration(milliseconds: 100), () {
            //   runApp(const ProviderScope(child: MaterialApp(home: App())));
            // });
          },
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}
