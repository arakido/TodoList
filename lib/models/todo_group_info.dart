import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_list/models/todo_info.dart';

class TodoGroupInfo {
  late String id;
  late String title;
  late Color color;
  late List<TodoInfo> todoList = [];

  TodoGroupInfo({
    required this.id,
    required this.title,
    required this.color,
  });

  void addTodoContent(String content) {
    TodoInfo info = TodoInfo(timer: DateTime.timestamp().toString(), content: content);
    todoList.add(info);
  }

  void addTodo(TodoInfo info) {
    todoList.add(info);
  }

  bool contains(String content){
    for (var data in todoList) {
      if(data.content == content) return true;
    }
    return false;
  }

  bool isComplete(){
    if(todoList.isEmpty) return false;
    for (var todo in todoList) {
      if (!todo.complete) return false;
    }
    return true;
  }

  TodoGroupInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = colorFromHex(json['color'].toString()) ?? Colors.white;

    List list = json['todoList'];
    for (var data in list) {
      TodoInfo info = TodoInfo.fromJson(data);
      addTodo(info);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['color'] = colorToHex(color);

    List list = [];
    for (var todo in todoList) {
      list.add(todo.toJson());
    }
    json['todoList'] = list;

    return json;
  }
}
