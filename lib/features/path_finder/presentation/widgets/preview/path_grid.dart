import 'package:flutter/material.dart';

import '../../../domain/entities/coordinate.dart';
import '../../../domain/entities/task_solution.dart';
import 'grid_cell.dart';

class PathGrid extends StatelessWidget {
  final TaskSolution solution;

  const PathGrid({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    final field = solution.task.field;

    return AspectRatio(
      aspectRatio: field.width / field.height,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: field.width * field.height,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: field.width,
        ),
        itemBuilder: (_, index) {
          // індекс у плоскому списку переводимо в координати сітки
          final coordinate = Coordinate(
            index % field.width,
            index ~/ field.width,
          );
          return GridCell(
            coordinate: coordinate,
            type: solution.cellTypeAt(coordinate),
          );
        },
      ),
    );
  }
}
