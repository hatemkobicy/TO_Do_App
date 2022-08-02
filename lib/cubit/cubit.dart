// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/cubit/states.dart';
import 'package:todo_list/modules/archive_task/archive_tasks_screen.dart';
import 'package:todo_list/modules/done_task/done_tasks_screen.dart';
import 'package:todo_list/modules/new_task/new_tasks_screen.dart';

class AppCupit extends Cubit<Appstates> {
  AppCupit() : super(AppInitialState());
  static AppCupit get(context) => BlocProvider.of(context);
  
  int currentindex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];

  List<String> titles = ["Tasks", "Done Tasks", "Archived Tasks"];

  void chingeindex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivedtasks = [];

  void createdatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      await database.execute(
          'create table tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)');
    }, onOpen: (database) {
      getDataFromeDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  inserttodatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")');
    }).then((value) {
      emit(AppInsertDataBaseState());
      getDataFromeDatabase(database);
    });
  }

  void getDataFromeDatabase(database) {
    Newtasks = [];
    Donetasks = [];
    Archivedtasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new')
            Newtasks.add(element);
          else if (element['status'] == 'done')
            Donetasks.add(element);
          else
            Archivedtasks.add(element);
        },
      );
      emit(AppGetDataBaseState());
    });
  }

  void updatedatabase({
    required status,
    required id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromeDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deletdatabase({
     id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?',
        [id]).then((value) {
      getDataFromeDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isbottonschetshown = false;
  IconData flipicon = Icons.edit;

  void changBottomsheetstate({required bool isshow, required IconData icon}) {
    isbottonschetshown = isshow;
    flipicon = icon;
    emit(AppChangeBottomSheetState());
  }
}
