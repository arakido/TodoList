import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_list/page/done_page.dart';
import 'package:todo_list/page/setting_page.dart';
import 'package:todo_list/page/togo_group_list_page.dart';
import 'package:todo_list/providers/todo_Provider.dart';

class TodoMainPage extends StatefulHookConsumerWidget {
  const TodoMainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TodoMainPageState();
  }
}

class _TodoMainPageState extends ConsumerState<TodoMainPage> {
  final List<Widget> _subPage = [
    const DonePage(),
    const TodoGroupListPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectIndex = ref.watch(selectPageIndex);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          ref.read(selectPageIndex.notifier).state = index;
        },
        currentIndex: selectIndex,
        fixedColor: Colors.deepPurple,
        backgroundColor: colorScheme.primary.withAlpha(50),
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.calendarCheck, size: 48,),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.calendar, size: 48,),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.tune, size: 48),
            label: ""
          ),
        ],
      ),
      body: _subPage[selectIndex],
    );
  }
}
