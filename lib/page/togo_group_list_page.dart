import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/page/page_open_route.dart';
import 'package:todo_list/page/new_todo_group_page.dart';
import 'package:todo_list/page/todo_group_card.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';
import 'package:todo_list/widget/top_split_line.dart';

class TodoGroupListPage extends StatefulHookConsumerWidget {
  const TodoGroupListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TaskPageState();
  }
}

class _TaskPageState extends ConsumerState<TodoGroupListPage> {
  int curIndex = 1;

  @override
  Widget build(BuildContext context) {
    final todoGroupLogic = ref.watch(todoLogicProvider);

    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              TopSplitLine(topPadding: 50, titleFlex: 4, lineFlex: 3, mainTitle: 'Todo', crossTitle: 'Group',),
              const SizedBox(height: 50,),
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 30,
                      onPressed: _addTaskPressed,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text('Add List', style: Theme.of(context).textTheme.labelLarge,),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50,),
          Expanded(
            child: Align(
              child: Container(
                height: 360,
                padding: const EdgeInsets.only(bottom: 25),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll){
                    overscroll.disallowIndicator();
                    return false;
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    scrollDirection: Axis.horizontal,
                    children: todoGroupLogic.todoGroupList.map((groupInfo) => TodoGroupCard(groupInfo: groupInfo)).toList(),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  void _addTaskPressed()  async {
    Navigator.of(context).push(pageOpenRoute(() => const NewTodoGroupPage()));
  }
}
