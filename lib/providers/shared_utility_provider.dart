import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo_group_info.dart';
import 'package:todo_list/utils/constants.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref){
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref){
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  final SharedPreferences sharedPreferences;
  SharedUtility({required this.sharedPreferences});

  bool isDarkModeEnabled(){
    return sharedPreferences.getBool(sharedDarkModeKey) ?? false;
  }

  void setDarkModeEnabled(bool value){
    sharedPreferences.setBool(sharedDarkModeKey, value);
  }

  List<TodoGroupInfo> loadTodoGroupList(){
    List<TodoGroupInfo> todoGroupList = [];
    List decodeOptions = jsonDecode(sharedPreferences.getString(todoGroupKey) ?? '[]');
    for (var json in decodeOptions) {
      todoGroupList.add(TodoGroupInfo.fromJson(json));
    }
    return todoGroupList;
  }

  void saveTodoGroupList(List<TodoGroupInfo> todoGroupList){
    if(todoGroupList.isEmpty){
      return;
    }
    String sharedData = jsonEncode(todoGroupList.map((group) => group.toJson()).toList());
    sharedPreferences.setString(todoGroupKey, sharedData);
  }

}