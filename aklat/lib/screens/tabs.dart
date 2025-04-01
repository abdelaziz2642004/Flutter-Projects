import 'package:Aklatoo/Provider/available_provider.dart';
import 'package:Aklatoo/Provider/category_provider.dart';
import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/filter_provider.dart';
import 'package:Aklatoo/Provider/meal_provider.dart';
import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/categories.dart';
import 'package:Aklatoo/screens/settings.dart';
import 'package:Aklatoo/screens/meals.dart';
import 'package:Aklatoo/screens/profile.dart';
import 'package:Aklatoo/screens/search.dart';
import 'package:Aklatoo/screens/verification.dart';
import 'package:Aklatoo/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 1;
  // Map<String, dynamic> _userData = {};
  User? _currentUser;

  @override
  void initState() {
    super.initState();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser; // Get current user
    if (_currentUser != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(_currentUser!.uid)
            .get();
        if (userDoc.exists) {
          // _userData = userDoc.data()!;
          // setState(() {});
          if (!_currentUser!.emailVerified) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VerificationScreen(user: _currentUser!),
              ),
            );
          }
        }
      } catch (error) {
        // Handle error while fetching user data
      }
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (ctx) => const FiltersScreen(),
      ));
    }
    if (identifier == 'meals') {
      setState(() {
        _selectedPageIndex = 1;
      });
    }
  }

  Future<void> signOut() async {
    bool shouldSignOut = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to Sign out?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
            ),
          ),
          TextButton(
            onPressed: () {
              shouldSignOut = true;
              Navigator.of(context).pop();
            },
            child: const Text(
              'Sign Out',
            ),
          ),
        ],
      ),
    );
    if (shouldSignOut) {
      ref.watch(mealsProvider.notifier).empty();
      ref.watch(availableCategoriesProvider.notifier).empty();
      ref.watch(filterProvider.notifier).empty();
      ref.watch(availableMealsProvider.notifier).empty();
      ref.read(favoriteMealsProvider.notifier).emptyonly();
      ref.read(profileDetailsProvider.notifier).emptyonly();
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.read(themeProvider);
    final favoritemeals = ref.watch(favoriteMealsProvider);
    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Aklatooo!';

    if (_selectedPageIndex == 0) {
      activePage = const ProfileScreen();
      activePageTitle = "My Profile";
    } else if (_selectedPageIndex == 1) {
      activePage = const CategoriesScreen();
      activePageTitle = "Aklatooo!";
    } else if (_selectedPageIndex == 2) {
      activePage = MealsScreen(
        meals: favoritemeals,
        mode: "fav",
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 10), // Space between icons
          GestureDetector(
            onTap: signOut,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0), // Padding for tap area
              child: Row(
                children: [
                  const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: signOut,
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 30, // Adjust icon size
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16), // Extra space to push icons from edge
        ],
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: _selectedPageIndex == 1
          ? SingleChildScrollView(child: activePage)
          : activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidStar),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor:
            theme == ThemeMode.dark ? Colors.white : Colors.black,
        backgroundColor: theme == ThemeMode.dark ? Colors.black : Colors.white,
        elevation: 15,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}
