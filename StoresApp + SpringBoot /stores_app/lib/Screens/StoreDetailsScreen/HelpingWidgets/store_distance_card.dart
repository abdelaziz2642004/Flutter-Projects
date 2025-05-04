import 'package:flutter/material.dart';
import 'package:store_app/Screens/StoreDetailsScreen/HelpingWidgets/store_colors.dart';

class StoreDistanceCard extends StatelessWidget {
  final AsyncSnapshot<double> snapshot;

  const StoreDistanceCard({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.directions_walk, color: primaryColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Distance to store', style: TextStyle(fontSize: 14, color: secondaryText, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xffc47c51)),
                  )
                else if (snapshot.hasError)
                  Text('Could not calculate distance', style: TextStyle(fontSize: 16, color: darkAccent, fontWeight: FontWeight.w600))
                else
                  Text('${snapshot.data?.toStringAsFixed(2)} meters', style: TextStyle(fontSize: 16, color: darkAccent, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
