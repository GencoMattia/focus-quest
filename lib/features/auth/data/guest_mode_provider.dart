import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestModeNotifier extends StateNotifier<bool> {
  GuestModeNotifier() : super(false);

  void enterGuestMode() => state = true;
  void exitGuestMode() => state = false;
}

final guestModeProvider = StateNotifierProvider<GuestModeNotifier, bool>((ref) {
  return GuestModeNotifier();
});
