import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/providers/todo_grpup_logic_provider.dart';
import 'package:todo_list/widget/app_title.dart';
import 'package:todo_list/widget/backup_list.dart';
import 'package:todo_list/widget/custom_button.dart';
import 'package:todo_list/providers/export_providers.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(storageProvider);
    void showAlert(String msg) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(msg),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ))
                ],
              ));
    }

    Future<File?> writeListOfTodoModel() async {
      final groupList = ref.read(todoLogicProvider).todoGroupList;

      File? file = await storage.writeData(groupList);
      if (file != null) {
        showAlert('Backup file created');
        return file;
      }
      showAlert("Error");
      return null;
    }

    void readListOfTodoModelFromFilePicker() async {
      List? todoListModel = await storage.readFromFilePicker();
      if (todoListModel != null) {
        ref.read(todoLogicProvider.notifier).saveData();
        showAlert('Data Loaded from the file');
      } else {
        showAlert("Data cant be Loaded");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          leadingTitle: "Backup &",
          trailingTitle: 'Restore',
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(isDarkProvider.notifier).toggleTheme();
            },
            icon: const Icon(Icons.color_lens_outlined, size: 30,))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              'Create backup',
              onTap: writeListOfTodoModel,
            ),
            CustomButton(
              'List of backup files',
              onTap: () async {
                List<String> listOfFiles = await storage.getListOfBackups();
                listOfFiles = listOfFiles.reversed.toList();
                Navigator.push(context, MaterialPageRoute(builder: (context) => BackupList(listOfFiles: listOfFiles)));
              },
            ),
            CustomButton(
              "Restore backup from storage",
              onTap: readListOfTodoModelFromFilePicker,
            )
          ],
        ),
      ),
    );
  }
}
