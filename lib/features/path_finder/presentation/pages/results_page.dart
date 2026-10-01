import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../domain/entities/task_solution.dart';
import '../widgets/results/result_tile.dart';

/// Список знайдених шляхів. Натискання відкриває перегляд сітки.
class ResultsPage extends StatelessWidget {
  final List<TaskSolution> solutions;

  const ResultsPage({super.key, required this.solutions});

  void _openPreview(BuildContext context, TaskSolution solution) {
    Navigator.of(context).pushNamed(AppRoutes.preview, arguments: solution);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: ListView.separated(
        itemCount: solutions.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final solution = solutions[index];
          return ResultTile(
            solution: solution,
            onTap: () => _openPreview(context, solution),
          );
        },
      ),
    );
  }
}
