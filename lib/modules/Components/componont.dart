// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/cubit/cubit.dart';



Widget defualtformfaild({
  required TextEditingController conttroler,
  required TextInputType type,
  onSubmit,
  onchanged,
  required valedit,
  required String title,
  required IconData preicon,
  ontap,
}) =>
    TextFormField(
      controller: conttroler,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onchanged,
      validator: valedit,
      onTap: ontap,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: Icon(preicon),
        border: OutlineInputBorder(),
      ),
    );

Widget tasksbuild(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.00,
              child: Text('${model['time']}',style: TextStyle(fontSize: 18),),
            ),
            SizedBox(width: 20.00),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                // ignore: prefer_const_literals_to_create_immutables

                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.00),
            IconButton(
              onPressed: () {
                AppCupit.get(context)
                    .updatedatabase(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box_rounded),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCupit.get(context)
                    .updatedatabase(status: 'archiv', id: model['id']);
              },
              icon: Icon(Icons.archive_rounded),
              color: Colors.black54,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCupit.get(context).deletdatabase(id: model['id']);
      },
    );

Widget tasksbuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: ((context, index) => tasksbuild(tasks[index], context)),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              Icons.menu,
              size: 55,
              color: Colors.black54,
            ),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            )
          ],
        ),
      ),
    );
