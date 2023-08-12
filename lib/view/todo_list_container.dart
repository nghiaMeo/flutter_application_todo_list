import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/view/todo_list.dart';
import 'package:flutter_application_todo_list/view/todo_list_header.dart';

class ToDoListContainer extends StatelessWidget {
  const ToDoListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: const Column(
        children: <Widget>[
          TodoListHeader(),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
