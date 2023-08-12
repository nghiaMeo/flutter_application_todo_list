import 'package:flutter_application_todo_list/db/todo_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  // ignore: constant_identifier_names
  static const DB_NAME = 'todo_db';
  // ignore: constant_identifier_names
  static const DB_VERSION = 1;
  // ignore: unused_field
  static late Database _database;

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];

  Database get database => _database;

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        // ignore: avoid_function_literals_in_foreach_calls
        initScripts.forEach(
          (script) async => await db.execute(script),
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // ignore: avoid_function_literals_in_foreach_calls
        migrationScripts.forEach(
          (script) async => await db.execute(script),
        );
      },
      version: DB_VERSION,
    );
  }
}
