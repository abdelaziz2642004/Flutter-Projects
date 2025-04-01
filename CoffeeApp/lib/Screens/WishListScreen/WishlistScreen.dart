import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/Logic.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/wishlistWidgets.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
  const WishlistScreen({super.key});
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  late WishlistLogic wishlistLogic;

  @override
  void initState() {
    super.initState();
    wishlistLogic = WishlistLogic(ref: ref);
    wishlistLogic.loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return WishlistWidgets(
      wishlistLogic: wishlistLogic,
      onCheckout: () {
        wishlistLogic.checkout();

        setState(() {
          print("helloooo");
        });
      },
      onRemoveItem: (index) {
        wishlistLogic.removeItem(index);

        setState(() {});
      },
      rebuild: () {
        setState(() {});
      },
    );
  }
}
