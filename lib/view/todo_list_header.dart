import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/bloc/todo_bloc.dart';
import 'package:flutter_application_todo_list/event/add_todo_event.dart';
import 'package:provider/provider.dart';

class TodoListHeader extends StatelessWidget {
  const TodoListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtToDoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: txtToDoController,
            decoration: const InputDecoration(
                labelText: 'Add ToDo', hintText: 'Add ToDo'),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        ElevatedButton.icon(
          onPressed: () {
            bloc.event.add(AddTodoEvent(content: txtToDoController.text));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        ),
      ],
    );
  }
}
