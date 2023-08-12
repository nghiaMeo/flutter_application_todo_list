import 'package:flutter_application_todo_list/base/base_event.dart';

class AddTodoEvent extends BaseEvent {
  late String content;
  AddTodoEvent({required this.content});
}
