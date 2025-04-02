import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_app/core/view_models/download_manager.dart';
import 'package:quran_app/core/widgets/app_bar_widget.dart';
import 'package:quran_app/core/widgets/bottom_navigation_widget.dart';
import 'package:quran_app/core/widgets/drawer_widget.dart';
import 'package:quran_app/core/widgets/tab_view_widget.dart';
import 'package:quran_app/features/onboarding/onboarding.dart';

import 'core/view_models/audio_handler.dart';
import 'core/widgets/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  final audioHandler = QuranAudioHandler();
  runApp(
    ProviderScope(
      child: BlocProvider(
        create: (BuildContext context) {
          return DownloadManager();
        },
        child: const QuranApp(),
      ),
    ),
  );
}

class QuranApp extends ConsumerWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider); // Watch theme state

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      // Use selected theme
      home: const OnboardingScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  void changeToRecitation() {
    _selectedIndex = 1;
    _tabController.index = 1;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  void _onItemTapped(int index) {
    _tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(), // Drawer with Dark Mode toggle
      body: CustomTabView(
        tabController: _tabController,
        func: changeToRecitation,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
