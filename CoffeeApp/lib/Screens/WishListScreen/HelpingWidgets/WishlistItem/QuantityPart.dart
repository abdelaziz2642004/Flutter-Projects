import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/WishlistItem.dart';

class quantityPart extends ConsumerWidget {
  const quantityPart({
    super.key,
    required this.item,
    required this.changeQuantity,
    required this.removeItem,
  });
  final WishlistItem item;
  final void Function(int, WidgetRef) changeQuantity;
  final void Function(WidgetRef) removeItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return Row(
      children: [
        const Spacer(),

        IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.grey, size: 30),
          onPressed: () {
            changeQuantity(-1, ref);
          },
        ),
        const SizedBox(width: 10),

        Text(
          '${item.quantity}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
            color: Color(0xffb2b2b2),
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),

        IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            changeQuantity(1, ref);
          },
        ),

        const SizedBox(width: 30),

        // Delete Button
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 196, 124, 81),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              removeItem(ref);
            },
          ),
        ),
      ],
    );
  }
}
