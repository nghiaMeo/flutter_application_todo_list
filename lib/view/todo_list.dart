import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/bloc/todo_bloc.dart';
import 'package:flutter_application_todo_list/event/delete_todo_event.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
          stream: bloc.todoListStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${snapshot.data?[index].content}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          bloc.event.add(
                            DeleteTodoEvent(snapshot.data![index]),
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                      ),
                    );
                  },
                );
              case ConnectionState.waiting:
                return Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const Text(
                      'Empty',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                );
              case ConnectionState.none:
              default:
                return Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const CircularProgressIndicator(),
                  ),
                );
            }
          }),
    );
  }
}
