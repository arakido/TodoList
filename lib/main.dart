import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_list/providers/shared_utility_provider.dart';
import 'package:todo_list/providers/storage_provider.dart';
import 'package:todo_list/providers/theme_provider.dart';
import 'package:todo_list/page/todo_main_page.dart';
import 'package:todo_list/utils/app_theme.dart';
import 'package:todo_list/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final storage = LocalStorage();

  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    storageProvider.overrideWithValue(storage),
  ], child: const TodoListApp()));
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final bool isDark = ref.watch(isDarkProvider).getTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? AppTheme.dark() : AppTheme.light(),
          home: const TodoMainPage(),
        );
      },
    );
  }
}
