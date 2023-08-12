// ignore_for_file: avoid_unnecessary_containers, unused_element, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/bloc/todo_bloc.dart';
import 'package:flutter_application_todo_list/db/todo_database.dart';
import 'package:flutter_application_todo_list/view/todo_list_container.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  databaseFactory = databaseFactoryFfi;
  await TodoDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 168, 188, 226)),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ToDo List'),
        ),
        // ignore: prefer_const_constructors
        body: Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: const ToDoListContainer(),
        ),
      ),
    );
  }
}
