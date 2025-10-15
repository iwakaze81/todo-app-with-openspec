import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:todo_app_with_openspec/src/app.dart';

void main() {
  testWidgets('TODOを追加し、完了状態を切り替えられる', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TodoApp()));
    await tester.pump();

    expect(find.text('まだTODOはありません'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '牛乳を買う');
    await tester.tap(find.widgetWithText(FilledButton, '追加'));
    await tester.pump();

    expect(find.text('牛乳を買う'), findsOneWidget);

    final checkbox = find.byType(Checkbox).first;
    expect(tester.widget<Checkbox>(checkbox).value, isFalse);

    await tester.tap(checkbox);
    await tester.pump();

    expect(tester.widget<Checkbox>(checkbox).value, isTrue);
  });
}
