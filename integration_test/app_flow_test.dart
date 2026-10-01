import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/app.dart';
import 'package:test_task/core/di/injection.dart';
import 'package:test_task/features/path_finder/presentation/widgets/preview/grid_cell.dart';
import 'package:test_task/features/path_finder/presentation/widgets/results/result_tile.dart';

/// Повний сценарій на реальному API: потрібне підключення до інтернету.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const apiUrl = 'https://flutter.webspark.dev/flutter/api';

  Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
    for (var i = 0; i < 100 && finder.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
    expect(finder, findsWidgets);
  }

  testWidgets('від введення url до перегляду результату', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await initDependencies();
    await tester.pumpWidget(const TestTaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start counting process'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a valid URL'), findsOneWidget);

    await tester.enterText(find.byType(TextField), apiUrl);
    await tester.tap(find.text('Start counting process'));

    await pumpUntilFound(tester, find.text('Send results to server'));
    expect(find.text('100%'), findsOneWidget);

    await tester.tap(find.text('Send results to server'));
    await pumpUntilFound(tester, find.text('Result list screen'));
    await tester.pumpAndSettle();

    final tiles = find.byType(ResultTile);
    expect(tiles, findsWidgets);
    expect(find.textContaining('->'), findsWidgets);

    await tester.tap(tiles.first);
    await tester.pumpAndSettle();

    expect(find.text('Preview screen'), findsOneWidget);
    expect(find.byType(GridCell), findsWidgets);
  });
}
