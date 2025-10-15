import 'package:uuid/uuid.dart';

import 'package:todo_app_with_openspec/src/domain/todo/todo.dart';
import 'package:todo_app_with_openspec/src/domain/todo/todo_repository.dart';

class TodoService {
  TodoService(this._repository);

  final TodoRepository _repository;
  final _uuid = const Uuid();

  Future<List<Todo>> loadTodos() {
    return _repository.fetchTodos();
  }

  Future<Todo> addTodo(String title) {
    final todo = Todo(id: _uuid.v4(), title: title);
    return _repository.saveTodo(todo);
  }

  Future<Todo> saveTodo(Todo todo) {
    return _repository.saveTodo(todo);
  }

  Future<void> removeTodo(String id) {
    return _repository.deleteTodo(id);
  }
}
