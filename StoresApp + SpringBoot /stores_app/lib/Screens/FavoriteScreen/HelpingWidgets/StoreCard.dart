import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Providers/favoriteStoresProvider.dart';
import 'package:store_app/Screens/FavoriteScreen/favoriteService.dart';
import 'package:store_app/Screens/StoreDetailsScreen/StoreDetailsScreen.dart';

class StoreCardFavorite extends ConsumerWidget {
  final Store store;
  final FavoriteService favoriteService;
  final void Function() rebuild;

  const StoreCardFavorite({
    required this.rebuild,
    super.key,
    required this.store,
    required this.favoriteService,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreDetailsScreen(store: store),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: store.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child:
                    store.imageBytes != null
                        ? Image.memory(
                          store.imageBytes!,
                          fit: BoxFit.cover,
                          height: 100,
                          width: double.infinity,
                        )
                        : const Icon(
                          Icons.store,
                          size: 100,
                          color: Colors.grey,
                        ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                store.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                store.description,
                style: TextStyle(color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${store.rating}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Customer customer = ref.read(customerProviderr);
                      ref
                          .read(favoriteStoresProvider(customer.ID).notifier)
                          .toggleFavorite(ref, store);
                      rebuild();
                    },
                    icon: const Icon(Icons.star),
                    color: Colors.amber,
                    iconSize: 30,
                    tooltip: 'Toggle Favorite',
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
