import 'package:equatable/equatable.dart';

import 'cell_type.dart';
import 'coordinate.dart';
import 'grid_task.dart';

/// Результат розрахунку для одного завдання.
class TaskSolution extends Equatable {
  final GridTask task;

  /// Комірки шляху від старту до фінішу включно. Порожній список — шляху немає.
  final List<Coordinate> steps;

  const TaskSolution({required this.task, required this.steps});

  bool get isFound => steps.isNotEmpty;

  /// Шлях у форматі (2.1)->(1.2)->(0.2)
  String get path => steps.join('->');

  /// Тип комірки для відображення на сітці.
  /// Порядок перевірок важливий: старт і фініш теж входять у [steps].
  CellType cellTypeAt(Coordinate c) {
    if (c == task.start) return CellType.start;
    if (c == task.end) return CellType.end;
    if (task.field.isBlocked(c)) return CellType.blocked;
    if (steps.contains(c)) return CellType.path;
    return CellType.empty;
  }

  @override
  List<Object?> get props => [task, steps];
}
