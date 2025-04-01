import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:prj/Providers/guestModeProvider.dart';

import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/LoginScreen/LoginScreen.dart';
import 'package:prj/Screens/Tabs%20(%20Screen%20Chooser%20)/tabs.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // most important 2 lines for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // most important 2 lines for firebase

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Widget Screen = Container();
  @override
  void initState() {
    super.initState();
    Screen = const Loginscreen();
    // ref.read(drinksProvider.notifier).fetchDrinks();

    // ref.read(categoriesProvider.notifier).fetchCats();
  }

  @override
  Widget build(BuildContext context) {
    final bool guest = ref.watch(
      guestModeProvider,
    ); // will get rebuild wheneevr the value changes , that's it :D much better than passing an ENTIRE FREAKING FUNCTION TO EVERY SMALL WIDGET

    Screen = guest ? const TabsScreen() : const Loginscreen();
    print(guest);

    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Lottie.asset('assets/JSON/loading.json'));
            }
            if (snapshot.hasData) {
              ref.invalidate(
                userProvider,
              ); // to refresh with the new data !! :D
              ref.watch(guestModeProvider.notifier).disableGuestMode();
              return const TabsScreen();
            } else {
              return Screen;
            }
          },
        ),
      ),
    );
  }
}
