// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, sized_box_for_whitespace, prefer_is_empty, import_of_legacy_library_into_null_safe, must_be_immutable, use_key_in_widget_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/cubit/cubit.dart';
import 'package:todo_list/cubit/states.dart';
import 'package:todo_list/modules/Components/componont.dart';

class HomeLayout extends StatelessWidget {
  var scafoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleControlar = TextEditingController();
  var timeControlar = TextEditingController();
  var dateControlar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCupit()..createdatabase(),
      child: BlocConsumer<AppCupit, Appstates>(
        listener: (BuildContext context, Appstates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: ((BuildContext context, Appstates state) {
          AppCupit cupit = AppCupit.get(context);
          return Scaffold(
            key: scafoldkey,
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                cupit.titles[cupit.currentindex],
              ),
              centerTitle: true,
            ),
            body: cupit.screens[cupit.currentindex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cupit.isbottonschetshown) {
                  if (formkey.currentState!.validate()) {
                    cupit.inserttodatabase(
                        title: titleControlar.text,
                        time: timeControlar.text,
                        date: dateControlar.text);
                  }
                } else {
                  scafoldkey.currentState
                      ?.showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defualtformfaild(
                                      conttroler: titleControlar,
                                      preicon: Icons.title,
                                      title: 'Task Title',
                                      type: TextInputType.text,
                                      valedit: (value) {
                                        if (value.isEmpty) {
                                          return ('Title Must Not Be Empty ');
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  defualtformfaild(
                                      conttroler: timeControlar,
                                      preicon: Icons.watch_later_outlined,
                                      title: 'Task Time',
                                      ontap: () {
                                        showTimePicker(
                                                confirmText: 'Enter',
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeControlar.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      type: TextInputType.none,
                                      valedit: (value) {
                                        if (value.isEmpty) {
                                          return ('Time Must Not Be Empty ');
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  defualtformfaild(
                                      conttroler: dateControlar,
                                      preicon: Icons.textsms_outlined,
                                      title: 'Task Date',
                                      ontap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-12-30'))
                                            .then((value) {
                                          dateControlar.text =
                                              DateFormat.yMMMd()
                                                  .format(value!)
                                                  .toString();
                                        });
                                      },
                                      type: TextInputType.none,
                                      valedit: (value) {
                                        if (value.isEmpty) {
                                          return ('Date Must Not Be Empty ');
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cupit.changBottomsheetstate(
                        isshow: false, icon: Icons.edit);
                  });
                  cupit.changBottomsheetstate(isshow: true, icon: Icons.add);
                }
              },
              child: Icon(cupit.flipicon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 20,
                currentIndex: cupit.currentindex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cupit.chingeindex(index);
                },
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: "Tasks",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: "Archive",
                  ),
                ]),
          );
        }),
      ),
    );
  }
}
