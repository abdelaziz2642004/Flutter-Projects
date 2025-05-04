import 'package:flutter/material.dart';
import 'package:store_app/Models/store.dart';
import 'package:store_app/Screens/StoreDetailsScreen/StoreDetailsScreen.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  final Color cardColor;
  final Color textColor;
  final Color secondaryText;
  final Color darkAccent;

  const StoreCard({
    super.key,
    required this.store,
    required this.cardColor,
    required this.textColor,
    required this.secondaryText,
    required this.darkAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StoreDetailsScreen(store: store)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: store.name,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))],
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                    ),
                    child: store.imageBytes != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(store.imageBytes!, fit: BoxFit.cover),
                    )
                        : Center(child: Icon(Icons.store, size: 36, color: darkAccent)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: const Color(0xffffb347), size: 20),
                          const SizedBox(width: 4),
                          Text(store.rating.toString(), style: TextStyle(color: darkAccent, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        store.description,
                        style: TextStyle(color: secondaryText, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: secondaryText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
