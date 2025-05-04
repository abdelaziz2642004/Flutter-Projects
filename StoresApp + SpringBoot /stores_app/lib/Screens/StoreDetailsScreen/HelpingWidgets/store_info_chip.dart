import 'package:flutter/material.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_colors.dart';

class StoreInfoChip extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? iconColor;

  const StoreInfoChip({super.key, required this.text, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? darkAccent, size: 18),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(fontSize: 14, color: darkAccent, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
