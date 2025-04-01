import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int favoritesCount;

  const StarRating({super.key, required this.favoritesCount});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Future<int> fetchTotalUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Meals')
        .doc('total')
        .get(); // Use get() to fetch the document
    return snapshot.data()?['total'] ??
        0; // Access the data safely and provide a default value
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: fetchTotalUsers(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //       child:
        //           CircularProgressIndicator()); // Center the loading indicator
        // } else if (snapshot.hasError) {
        //   return Text('Error: ${snapshot.error}'); // Handle error
        // } else if (!snapshot.hasData || snapshot.data == 0) {
        //   return const Text('No users found'); // Handle no users case
        // }

        int totalUsers = snapshot.data ?? 0;

        // Calculate the rating based on favorites count
        double rating =
            totalUsers > 0 ? widget.favoritesCount / totalUsers : 0.0;
        final scaledRating = rating * 5;

        // Calculate the percentage of users who rated
        var favoritedPercentage =
            totalUsers > 0 ? (rating * 100).toStringAsFixed(0) : '0';
        if (int.parse(favoritedPercentage) > 100) {
          favoritedPercentage = '100';
        } else if (int.parse(favoritedPercentage) < 0) {
          favoritedPercentage = '0';
        }

        return Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(5, (index) {
                // Display full stars, half stars, or empty stars based on the scaled rating
                if (index < scaledRating.floor()) {
                  return const Icon(Icons.star,
                      color: Color.fromARGB(255, 249, 194, 15));
                } else if (index < scaledRating && scaledRating % 1 >= 0.5) {
                  return const Icon(Icons.star_half,
                      color: Color.fromARGB(255, 249, 194, 15));
                } else {
                  return const Icon(Icons.star_border,
                      color: Color.fromARGB(255, 249, 194, 15));
                }
              }),
            ),
            const SizedBox(height: 8),
            Text(
              'Favorited $favoritedPercentage% of the time',
              style: const TextStyle(
                  color: Color.fromARGB(255, 234, 180, 0), fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
