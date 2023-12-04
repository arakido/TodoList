import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/page/todo_group_card.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';
import 'package:todo_list/widget/top_split_line.dart';

class DonePage extends StatefulHookConsumerWidget{
  const DonePage({super.key});

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() {
    return _DonePageState();
  }
}

class _DonePageState extends ConsumerState<DonePage> {
  @override
  Widget build(BuildContext context) {
    final todoGroupLogic = ref.watch(todoLogicProvider);
    return Scaffold(
      body: ListView(
        children: [
          TopSplitLine(topPadding: 50, titleFlex: 4, mainTitle: 'Done', lineFlex: 3, crossTitle: 'Group',),
          Container(
            height: 360,
            margin: const EdgeInsets.only(top: 175, bottom: 25),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll){
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                scrollDirection: Axis.horizontal,
                children: todoGroupLogic.todoGroupList.where((groupInfo) => groupInfo.isComplete()).map((groupInfo) => TodoGroupCard(groupInfo: groupInfo)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}