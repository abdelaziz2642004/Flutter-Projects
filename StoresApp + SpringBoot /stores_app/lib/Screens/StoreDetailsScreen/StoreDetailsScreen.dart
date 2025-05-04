import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Models/store.dart';

import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_details_body.dart';
import 'package:store_app/Screens/StoreDetailsScreen/distanceService.dart';

class StoreDetailsScreen extends ConsumerStatefulWidget {
  final Store store;
  const StoreDetailsScreen({super.key, required this.store});

  @override
  ConsumerState<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends ConsumerState<StoreDetailsScreen> {
  final DistanceService distanceService = DistanceService();
  String? _address;
  bool _loadingAddress = false;

  @override
  void initState() {
    super.initState();
    _getAddressFromCoordinates();
  }

  Future<void> _getAddressFromCoordinates() async {
    setState(() => _loadingAddress = true);
    final address = await distanceService.getAddressFromCoordinates(
      widget.store,
    );
    setState(() {
      _address = address ?? 'Address not available';
      _loadingAddress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This line is used to trigger a rebuild when the provider changes.
    return StoreDetailsBody(
      store: widget.store,
      address: _address,
      loadingAddress: _loadingAddress,
      distanceService: distanceService,
    );
  }
}
