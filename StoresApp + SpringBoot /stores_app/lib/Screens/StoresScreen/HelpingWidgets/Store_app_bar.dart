import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/ProfileScreen/profileScreen.dart';
import 'package:store_app/Screens/StoresScreen/HelpingWidgets/colors.dart';

class StoreAppBar extends ConsumerWidget {
  final String text;

  const StoreAppBar({required this.text, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProviderr);
    return SliverAppBar(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      elevation: 4,
      pinned: true,
      floating: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              radius: 22,
              backgroundImage:
                  (customer.imageBytes == null || customer.imageBytes!.isEmpty)
                      ? const AssetImage("assets/images/image.png")
                      : MemoryImage(customer.imageBytes!) as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
