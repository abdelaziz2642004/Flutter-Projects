import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Notification.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/NotificationScreen/HelpingWidgets/notificationItem.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  List<myNotification> notifications = [];
  String? emptyMessage;

  @override
  void didChangeDependencies() {
    // it says this is better than initstate , will see more to that
    super.didChangeDependencies();
    final currentUser = ref.read(userProvider).value ?? user();
    setState(() {
      notifications = currentUser.notifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body:
          notifications.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    emptyMessage ?? "No notifications yet.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'DopisBold',
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NotificationItem(item: notifications[index]);
                },
              ),
    );
  }
}
