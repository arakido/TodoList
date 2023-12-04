import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/models/todo_group_info.dart';
import 'package:todo_list/models/todo_info.dart';
import 'package:todo_list/providers/export_providers.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final todoLogicProvider = ChangeNotifierProvider<TodoLogic>((ref) {
  final sharedUtil = ref.watch(sharedUtilityProvider);
  return TodoLogic(sharedUtil);
});

class TodoLogic extends ChangeNotifier {
  final SharedUtility sharedUtility;
  late List<TodoGroupInfo> todoGroupList = [];

  TodoLogic(this.sharedUtility){
    todoGroupList = sharedUtility.loadTodoGroupList();
  }

  void addGroup(String title, Color color) {
    if (title.isEmpty) return;
    todoGroupList.add(TodoGroupInfo(id: _uuid.v4(), title: title, color: color));
    saveData();
  }

  void addTodo(TodoGroupInfo groupInfo, content){
    groupInfo.addTodoContent(content);
    saveData();
  }

  void deleteTodo(TodoGroupInfo groupInfo, TodoInfo todo){
    groupInfo.todoList.remove(todo);
    saveData();
  }

  void changeTodoState(TodoInfo todoInfo){
    todoInfo.complete = !todoInfo.complete;
    saveData();
  }

  void saveData(){
    sharedUtility.saveTodoGroupList(todoGroupList);
    notifyListeners();
  }
}
