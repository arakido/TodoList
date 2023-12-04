import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_list/models/todo_group_info.dart';

abstract class Storage {
  Future<File?> writeData(List<TodoGroupInfo> todoGroupList);
  Future<List<TodoGroupInfo>?> readData(File selectFile);
  Future<List<TodoGroupInfo>?> readFromFilePicker();
  Future<List<String>> getListOfBackups();
  void share(String path);
}

class LocalStorage extends Storage {

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _localFile async {
    DateTime time = DateTime.now();
    final path = await _localPath;
    return File('$path/backup-$time.json');
  }

  @override
  Future<List<String>> getListOfBackups() async {
    final directory = await getExternalStorageDirectory();

    List<String> fileList = [];
    List<FileSystemEntity> allFiles = directory?.listSync() ?? [];

    for (final file in allFiles) {
      fileList.add(file.path);
    }
    return fileList;
  }

  @override
  Future<File?> writeData(List<TodoGroupInfo> todoGroupList) async {
    if (!await Permission.storage.request().isGranted) {
      return Future.value(null);
    }
    final file = await _localFile;
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    if (todoGroupList.isEmpty) {
      return file.writeAsString('[]');
    }

    String encodedData = jsonEncode(todoGroupList.map((groupInfo) => groupInfo.toJson()).toList());
    return file.writeAsString(encodedData);
  }

  @override
  Future<List<TodoGroupInfo>?> readData(File selectFile) async {
    try {
      final jsonData = await selectFile.readAsString();
      List jsonResponse = jsonDecode(jsonData);
      return jsonResponse.map((json) => TodoGroupInfo.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<TodoGroupInfo>?> readFromFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null || !result.files.single.path!.endsWith('.json')) {
      return null;
    }

    File file = File(result.files.single.path!);
    List<TodoGroupInfo>? todoListModel = await readData(file);
    writeData(todoListModel!);
    return todoListModel;
  }

  @override
  void share(String path) async {}
}
