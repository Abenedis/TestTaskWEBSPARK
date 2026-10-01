import 'package:equatable/equatable.dart';

import 'task_solution.dart';

/// Проміжний стан розрахунку: скільки завдань уже розв'язано із загальної кількості.
class SolvingProgress extends Equatable {
  final int total;
  final List<TaskSolution> solutions;

  const SolvingProgress({required this.total, required this.solutions});

  bool get isCompleted => solutions.length >= total;

  /// Значення від 0 до 100.
  int get percent => total == 0 ? 100 : (solutions.length * 100) ~/ total;

  @override
  List<Object?> get props => [total, solutions];
}
