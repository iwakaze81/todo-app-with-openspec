import 'dart:async';

import 'package:todo_app_with_openspec/src/domain/todo/todo.dart';
import 'package:todo_app_with_openspec/src/domain/todo/todo_repository.dart';

class InMemoryTodoRepository implements TodoRepository {
  final Map<String, Todo> _store = {};

  @override
  Future<List<Todo>> fetchTodos() async {
    return _store.values.toList(growable: false);
  }

  @override
  Future<Todo> saveTodo(Todo todo) async {
    _store[todo.id] = todo;
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    _store.remove(id);
  }
}
