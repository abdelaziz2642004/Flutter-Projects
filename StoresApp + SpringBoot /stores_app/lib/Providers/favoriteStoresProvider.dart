import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Screens/FavoriteScreen/favoriteService.dart';

// StateNotifier to manage the list of favorite stores
class FavoriteStoresNotifier extends StateNotifier<AsyncValue<List<Store>>> {
  final FavoriteService favoriteService;
  final int customerId;

  FavoriteStoresNotifier(this.favoriteService, this.customerId)
    : super(const AsyncValue.loading()) {
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      state = const AsyncValue.loading();
      final stores = await FavoriteService.fetchFavoritedStores(customerId);
      state = AsyncValue.data(stores);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Toggle favorite and refresh the list
  Future<void> toggleFavorite(WidgetRef ref, Store store) async {
    try {
      await FavoriteService.toggleFavorite(ref, store.id);

      final currentStores = state.valueOrNull ?? [];
      final isFavorite = currentStores.any((s) => s.id == store.id);
      final updatedStores =
          isFavorite
              ? currentStores.where((s) => s.id != store.id).toList()
              : [...currentStores, store];

      state = AsyncValue.data(updatedStores);
    } catch (e, stack) {
      // Revert to previous state on error
      state = AsyncValue.error(e, stack);
    }
  }
}

final favoriteStoresProvider = StateNotifierProvider.family<
  FavoriteStoresNotifier,
  AsyncValue<List<Store>>,
  int
>((ref, customerId) {
  final favoriteService = FavoriteService();
  return FavoriteStoresNotifier(favoriteService, customerId);
});
