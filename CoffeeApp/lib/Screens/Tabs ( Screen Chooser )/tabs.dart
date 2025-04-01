import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prj/Screens/FavoriteScreen/FavortieScreen.dart';
import 'package:prj/Screens/HomeScreen/HomeScreen.dart';
import 'package:prj/Screens/NotificationScreen/notificationScreen.dart';
import 'package:prj/Screens/Tabs%20(%20Screen%20Chooser%20)/BottomNavBar.dart';
import 'package:prj/Screens/WishListScreen/WishlistScreen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsState();
}

class _TabsState extends ConsumerState<TabsScreen> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void rebuild(int index) {
    setState(() {
      _index = index;
    });
  }

  Widget _buildScreenChooser(int index, void Function(int) rebuild) {
    switch (index) {
      case 0:
        return const Homescreen();
      case 1:
        return const FavoritesScreen();

      case 2:
        return const WishlistScreen();

      case 3:
        return const NotificationsScreen();
      default:
        return const Homescreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    Widget buildScreen = _buildScreenChooser(_index, rebuild);
    return SafeArea(
      child: Scaffold(
        body: buildScreen,
        bottomNavigationBar: Bottomnavbar(index: _index, rebuild: rebuild),
      ),
    );
  }
}
