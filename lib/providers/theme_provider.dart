import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/providers/shared_utility_provider.dart';

final isDarkProvider = ChangeNotifierProvider<DarkThemeNotifier>((ref) => DarkThemeNotifier(ref));

class DarkThemeNotifier extends ChangeNotifier {
  Ref ref;
  DarkThemeNotifier(this.ref);
  
  bool getTheme(){
    return ref.watch(sharedUtilityProvider).isDarkModeEnabled();
  }

  void toggleTheme(){
    ref.watch(sharedUtilityProvider).setDarkModeEnabled(!ref.watch(sharedUtilityProvider).isDarkModeEnabled());
    notifyListeners();
  }
}