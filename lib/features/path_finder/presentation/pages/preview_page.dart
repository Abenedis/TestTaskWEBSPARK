import 'package:flutter/material.dart';

import '../../domain/entities/task_solution.dart';
import '../widgets/preview/path_grid.dart';

/// Сітка з підсвіченим шляхом і сам шлях текстом під нею.
class PreviewPage extends StatelessWidget {
  final TaskSolution solution;

  const PreviewPage({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PathGrid(solution: solution),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  solution.isFound ? solution.path : 'Path not found',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
