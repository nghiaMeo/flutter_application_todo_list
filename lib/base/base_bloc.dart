// ignore: camel_case_types
// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_todo_list/base/base_event.dart';

// ignore: camel_case_types
abstract class baseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  baseBloc() {
    _eventStreamController.stream.listen((event) {
      // ignore: unnecessary_type_check
      if (event is! BaseEvent) {
        throw Exception('Event khong hop le');
      }
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
