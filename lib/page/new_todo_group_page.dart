import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';
import 'package:todo_list/widget/pick_color.dart';
import 'package:todo_list/widget/top_split_line.dart';

class NewTodoGroupPage extends StatefulHookConsumerWidget{
  const NewTodoGroupPage({super.key});

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() {
    return _NewTodoGroupPageState();
  }
}

class _NewTodoGroupPageState extends ConsumerState<NewTodoGroupPage> {
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Color? pickerColor = Color.fromARGB(
      250,
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255));

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 40),
              child: const BackButton(color: Colors.white,),
            ),
            Column(
              children: [
                TopSplitLine(topPadding: 100, titleFlex: 4, lineFlex: 3, mainTitle: 'New', crossTitle: 'Group',),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Group Title',
                          contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 5),
                        ),
                        controller: titleController,
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        //maxLines: 20,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return pickColor(pickerColor!, (color){
                                setState(() {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    pickerColor = color;
                                  });
                                });
                              });
                            });
                          },
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(3),
                            backgroundColor: MaterialStatePropertyAll(pickerColor),
                            foregroundColor: const MaterialStatePropertyAll(Colors.white)
                          ),
                          child: const Text('Card Color'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextButton(
                    onPressed: (){
                      _saving = true;
                      ref.read(todoLogicProvider).addGroup(titleController.text, pickerColor!);
                      Navigator.of(context).pop();
                    },
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(4),
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        surfaceTintColor: MaterialStatePropertyAll(Colors.deepPurple)
                    ),
                    child: const Text("Add", style: TextStyle(color: Colors.white),),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }
}