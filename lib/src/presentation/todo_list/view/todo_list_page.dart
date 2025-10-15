import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_app_with_openspec/src/application/todo/todo_providers.dart';
import 'package:todo_app_with_openspec/src/domain/todo/todo.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final controller = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('TODO リスト')),
      body: todos.when(
        data: (items) => _TodoListView(
          todos: items,
          onToggle: (todo) => ref.read(todoListProvider.notifier).toggle(todo),
          onRemove: (todo) =>
              ref.read(todoListProvider.notifier).remove(todo.id),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('読み込みに失敗しました: $error')),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: '新しいTODOを入力'),
                  onSubmitted: (value) => _handleSubmit(ref, controller, value),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () =>
                    _handleSubmit(ref, controller, controller.text),
                child: const Text('追加'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit(
    WidgetRef ref,
    TextEditingController controller,
    String value,
  ) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return;
    }

    ref.read(todoListProvider.notifier).add(trimmed);
    controller.clear();
  }
}

class _TodoListView extends StatelessWidget {
  const _TodoListView({
    required this.todos,
    required this.onToggle,
    required this.onRemove,
  });

  final List<Todo> todos;
  final ValueChanged<Todo> onToggle;
  final ValueChanged<Todo> onRemove;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('まだTODOはありません'));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggle(todo),
          ),
          title: Text(
            todo.title,
            style: todo.isCompleted
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => onRemove(todo),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: todos.length,
    );
  }
}
