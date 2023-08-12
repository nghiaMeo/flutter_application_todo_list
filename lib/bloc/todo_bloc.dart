// ignore_for_file: prefer_final_fields, unnecessary_overrides

import 'dart:async';
import 'dart:math';

import 'package:flutter_application_todo_list/base/base_bloc.dart';
import 'package:flutter_application_todo_list/base/base_event.dart';
import 'package:flutter_application_todo_list/db/todo_table.dart';
import 'package:flutter_application_todo_list/event/add_todo_event.dart';
import 'package:flutter_application_todo_list/event/delete_todo_event.dart';
import 'package:flutter_application_todo_list/model/todo.dart';

class TodoBloc extends baseBloc {
  StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();

  // ignore: unused_field
  TodoTable _todoTable = TodoTable();

  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;
  var _randomInt = Random();

  // ignore: unused_field
  List<Todo> _todoListData = [];

  _addTodo(Todo todo) async {
    //insert database
    await _todoTable.insertTodo(todo);
    _todoListData.add(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);
    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if (_todoListData == null) {
      print('empty');
    } else {
      _todoListStreamController.sink.add(_todoListData);
    }
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(_randomInt.nextInt(2000), event.content);
      _addTodo(todo);
      print(event.content);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
      print('delete event');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
