import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/screens/signIn.dart';
import 'package:Aklatoo/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

// Define your light and dark themes here
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 107, 6, 223),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 107, 6, 223),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.watch(themeProvider.notifier).loadTheme();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the theme mode

    final isDarkMode = ref.watch(themeProvider);
    // isDarkMode == ThemeMode.dark ? darkTheme : lightTheme

    return MaterialApp(
      theme: isDarkMode == ThemeMode.dark ? darkTheme : lightTheme,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Lottie.asset('assets/cooking.json'));
            }
            return (snapshot.hasData) ? const TabsScreen() : const Login();
          },
        ),
      ),
    );
  }
}
