import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:prj/Models/Notification.dart';
import 'package:prj/Screens/DetailsScreen.dart/Details.dart';

class NotificationItem extends StatelessWidget {
  final myNotification item;

  const NotificationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.coffee.name != "null") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoffeeDetailsScreen(coffee: item.coffee),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 213, 200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  item.coffee.name != "null"
                      ? CachedNetworkImage(
                        imageUrl: item.coffee.imageUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                      : Container(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.message,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'DopisBold',
                  color: Colors.black,
                ),
              ),
            ),
            item.coffee.name != "null"
                ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
