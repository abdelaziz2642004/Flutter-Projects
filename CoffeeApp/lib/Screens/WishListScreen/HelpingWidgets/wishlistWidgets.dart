import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/WishlistItem/WishlistItem.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/Logic.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/finish/finish.dart';

class WishlistWidgets extends ConsumerWidget {
  final WishlistLogic wishlistLogic;
  final VoidCallback onCheckout;
  final Function(int) onRemoveItem;
  final Function() rebuild;

  const WishlistWidgets({super.key, 
    required this.wishlistLogic,
    required this.onCheckout,
    required this.onRemoveItem,
    required this.rebuild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            'Wishlist',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Items (${wishlistLogic.wishlist.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DopisBold',
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onCheckout,
                    icon: const Icon(Icons.delete_outline),
                    color: const Color(0xffc47c51),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: wishlistLogic.wishlist.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(wishlistLogic.wishlist[index].coffee.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 67, 54),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                      onDismissed: (direction) => onRemoveItem(index),
                      child: CartItemCard(
                        item: wishlistLogic.wishlist[index],
                        rebuild: rebuild,
                      ),
                    );
                  },
                ),
              ),
              if (wishlistLogic.wishlist.isNotEmpty) finish(onCheckout, ref),
            ],
          ),
        ),
      ),
    );
  }
}
