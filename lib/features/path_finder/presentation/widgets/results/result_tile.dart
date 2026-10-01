import 'package:flutter/material.dart';

import '../../../domain/entities/task_solution.dart';

class ResultTile extends StatelessWidget {
  final TaskSolution solution;
  final VoidCallback onTap;

  const ResultTile({super.key, required this.solution, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        solution.isFound ? solution.path : 'Path not found',
        textAlign: TextAlign.center,
      ),
      onTap: onTap,
    );
  }
}
