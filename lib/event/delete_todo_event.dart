import 'package:flutter_application_todo_list/base/base_event.dart';

import '../model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  late Todo todo;
  DeleteTodoEvent(this.todo);
}
