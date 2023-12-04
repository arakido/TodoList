import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/models/todo_group_info.dart';
import 'package:todo_list/models/todo_info.dart';
import 'package:todo_list/page/new_todo_page.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';
import 'package:todo_list/widget/pick_color.dart';

class TodoGroupPage extends StatefulHookConsumerWidget{
  final TodoGroupInfo groupInfo;
  const TodoGroupPage({super.key, required this.groupInfo});

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() {
    return _TodoGroupPageState();
  }
}

class _TodoGroupPageState extends ConsumerState<TodoGroupPage> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(todoLogicProvider);
    final todoList = widget.groupInfo.todoList;
    return Scaffold(
      backgroundColor: widget.groupInfo.color,
      body: Column(
        children: [
          _topBar(),
          Row(
            children: [
              Expanded(child: Container(color: Colors.grey, height: 1.5,)),
              Expanded(child: Container(
                alignment: Alignment.center,
                child: Text("${todoList.where((todo) => !todo.complete).length} / ${todoList.length}"),)
              ),
              Expanded(child: Container(color: Colors.grey, height: 1.5,))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, top: 30, right: 50),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll){
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: todoItem(todoList[index]),
                    );
                  },
                ),
              ),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return newTodoDialog(widget.groupInfo.color, (String content){
              Navigator.of(context).pop();
              if(content.isNotEmpty && !widget.groupInfo.contains(content)){
                setState(() {
                  ref.read(todoLogicProvider).addTodo(widget.groupInfo, content);
                });
              }
            });
          });
        },
        child: const Icon(Icons.add, size: 40,),
      ),
    );
  }

  Padding _topBar(){
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
          ),
          Flexible(
            child: Text(
              widget.groupInfo.title,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            offset: const Offset(0, 40),
            onSelected: (value) {
              if (value == 1){
                showDialog(context: context, builder: (BuildContext context){
                  return pickColor(widget.groupInfo.color, (color){
                    setState(() {
                      Navigator.of(context).pop();
                      setState(() {
                        widget.groupInfo.color = color;
                      });
                    });
                  });
                });
              }
              else{

              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.color_lens_outlined),
                  title: Text("Color",),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Slidable todoItem(TodoInfo todo){
    return Slidable(
      useTextDirection: false,
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (BuildContext context) {
              ref.read(todoLogicProvider).deleteTodo(widget.groupInfo, todo);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: (){
          ref.read(todoLogicProvider).changeTodoState(todo);
        },
        child: Container(
          //height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(30),
            borderRadius: BorderRadius.circular(24)
          ),
          //color: info.complete ? Color(0xFFF0F0F0) : Color(0xFFFCFCFC),
          child: ListTile(
            leading: Icon(todo.complete? Icons.task_alt : Icons.circle_outlined,),
            title: Text(todo.content, style: TextStyle(
              decoration: todo.complete? TextDecoration.lineThrough : TextDecoration.none, fontSize: 27
            ),),
          ),
        ),
      ),
    );
  }
}

