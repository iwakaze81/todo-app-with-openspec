import 'todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<Todo> saveTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
