// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/cubit.dart';
import 'package:todo_list/cubit/states.dart';
import 'package:todo_list/modules/Components/componont.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCupit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCupit.get(context).Donetasks;
        return tasksbuilder(tasks: tasks);
       },
    );
  }
}
