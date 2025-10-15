import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_app_with_openspec/src/application/todo/todo_service.dart';
import 'package:todo_app_with_openspec/src/domain/todo/todo.dart';

class TodoListController extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoListController(this._service) : super(const AsyncValue.data([])) {
    load();
  }

  final TodoService _service;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final todos = await _service.loadTodos();
      state = AsyncValue.data(todos);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> add(String title) async {
    final current = state.value ?? const <Todo>[];
    final updated = [...current, await _service.addTodo(title)];
    state = AsyncValue.data(updated);
  }

  Future<void> toggle(Todo todo) async {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _service.saveTodo(updatedTodo);
    final next = [
      for (final item in state.value ?? const <Todo>[])
        if (item.id == todo.id) updatedTodo else item,
    ];
    state = AsyncValue.data(next);
  }

  Future<void> remove(String id) async {
    await _service.removeTodo(id);
    state = AsyncValue.data([
      for (final item in state.value ?? const <Todo>[])
        if (item.id != id) item,
    ]);
  }
}
