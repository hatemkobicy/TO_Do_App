// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/cubit.dart';
import 'package:todo_list/cubit/states.dart';
import 'package:todo_list/modules/Components/componont.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCupit.get(context).Archivedtasks;
        return tasksbuilder(tasks: tasks);
      },
    );
  }
}
