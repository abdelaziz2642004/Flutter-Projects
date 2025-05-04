import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Providers/favoriteStoresProvider.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_colors.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_distance_card.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_info_chip.dart';
import 'package:store_app/Screens/StoreDetailsScreen/distanceService.dart';

class StoreDetailsBody extends ConsumerStatefulWidget {
  final Store store;
  final String? address;
  final bool loadingAddress;
  final DistanceService distanceService;

  const StoreDetailsBody({
    super.key,
    required this.store,
    required this.address,
    required this.loadingAddress,
    required this.distanceService,
  });

  @override
  ConsumerState<StoreDetailsBody> createState() => _StoreDetailsBodyState();
}

class _StoreDetailsBodyState extends ConsumerState<StoreDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProviderr);
    final favoritedStoresAsync = ref.watch(favoriteStoresProvider(customer.ID));
    final Future<double> distance = widget.distanceService.getDistanceToStore(
      widget.store,
    );

    return FutureBuilder<double>(
      future: distance,
      builder: (context, snapshot) {
        String distanceText;
        if (snapshot.connectionState == ConnectionState.waiting) {
          distanceText = 'Calculating distance...';
        } else if (snapshot.hasError) {
          distanceText = 'Distance unavailable';
        } else {
          distanceText = '${snapshot.data?.toStringAsFixed(2)} m away';
        }

        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                widget.store.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: widget.store.name,
                        child: Container(
                          height: 320,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  widget.store.imageBytes != null
                                      ? MemoryImage(widget.store.imageBytes!)
                                      : const AssetImage(
                                            'assets/images/image.png',
                                          )
                                          as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                primaryColor.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StoreInfoChip(text: distanceText),
                            const SizedBox(height: 10),
                            StoreInfoChip(
                              text: '${widget.store.rating} ★',
                              icon: Icons.star,
                              iconColor: const Color(0xffffb347),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.store.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const Spacer(),
                            favoritedStoresAsync.when(
                              data: (favoritedStores) {
                                // bool ok = favoritedStores[0] == widget.store;

                                // print(ok);
                                // print(favoritedStores[0]);
                                // print(widget.store);
                                return IconButton(
                                  onPressed: () async {
                                    // await favoriteService.toggleFavorite(
                                    //   widget.store,
                                    // );
                                    // setState(() {});

                                    Customer customer = ref.read(
                                      customerProviderr,
                                    );
                                    ref
                                        .read(
                                          favoriteStoresProvider(
                                            customer.ID,
                                          ).notifier,
                                        )
                                        .toggleFavorite(ref, widget.store);
                                  },
                                  icon: Icon(
                                    favoritedStores.any(
                                          (store) =>
                                              store.id == widget.store.id,
                                        )
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 32,
                                    color: const Color(0xffffb347),
                                  ),
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                              error:
                                  (error, stack) => IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).clearSnackBars();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "❌ Not connected to backend. Try again later.",
                                          ),
                                        ),
                                      );
                                      return;
                                    },
                                    icon: const Icon(
                                      Icons.star_border,
                                      size: 32,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.store.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryText,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  widget.loadingAddress
                                      ? const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xffc47c51),
                                      )
                                      : Text(
                                        widget.address ??
                                            'Address not available',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: secondaryText,
                                        ),
                                      ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Coordinates: ${widget.store.latitude.toStringAsFixed(4)}, ${widget.store.longitude.toStringAsFixed(4)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: secondaryText.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        StoreDistanceCard(snapshot: snapshot),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
