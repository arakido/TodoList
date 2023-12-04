import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/models/todo_group_info.dart';
import 'package:todo_list/models/todo_info.dart';
import 'package:todo_list/page/page_open_route.dart';
import 'package:todo_list/page/todo_group_page.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';

class TodoGroupCard extends ConsumerWidget{
  final TodoGroupInfo groupInfo;
  const TodoGroupCard({super.key, required this.groupInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(todoLogicProvider);
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(pageOpenRoute(()=>
          TodoGroupPage(groupInfo: groupInfo)
        ));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        color: groupInfo.color,
        child: SizedBox(
          width: 220,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  groupInfo.title,
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50),
                color: Colors.white,
                height: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 15, right: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: groupInfo.todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return todoItem(groupInfo.todoList[index], ref);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile todoItem(TodoInfo todo, WidgetRef ref){
    return ListTile(
      onTap: (){
        ref.read(todoLogicProvider).changeTodoState(todo);
      },
      leading: Icon(todo.complete? Icons.task_alt : Icons.circle_outlined,),
      title: Text(todo.content, style: TextStyle(
          decoration: todo.complete? TextDecoration.lineThrough : TextDecoration.none, fontSize: 27
      ),),
    );
  }

}