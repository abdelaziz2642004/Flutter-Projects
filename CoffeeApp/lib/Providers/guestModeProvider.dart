import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestModeProvider = StateNotifierProvider<GuestModeNotifier, bool>((ref) {
  return GuestModeNotifier();
});

class GuestModeNotifier extends StateNotifier<bool> {
  GuestModeNotifier()
    : super(
        FirebaseAuth.instance.currentUser == null ? false : false,
      ); // default is not guest mode

  void enableGuestMode() {
    state = true;
  }

  void disableGuestMode() {
    state = false;
  }
}
