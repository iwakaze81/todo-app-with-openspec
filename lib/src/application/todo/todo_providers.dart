import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_app_with_openspec/src/domain/todo/todo.dart';
import 'package:todo_app_with_openspec/src/domain/todo/todo_repository.dart';
import 'package:todo_app_with_openspec/src/infrastructure/todo/in_memory_todo_repository.dart';
import 'package:todo_app_with_openspec/src/presentation/todo_list/view_model/todo_list_view_model.dart';

import 'todo_service.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return InMemoryTodoRepository();
});

final todoServiceProvider = Provider<TodoService>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return TodoService(repository);
});

final todoListProvider =
    StateNotifierProvider<TodoListController, AsyncValue<List<Todo>>>((ref) {
      final service = ref.watch(todoServiceProvider);
      return TodoListController(service);
    });
