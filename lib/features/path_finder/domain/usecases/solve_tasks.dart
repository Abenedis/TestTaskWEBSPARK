import '../entities/grid_task.dart';
import '../entities/solving_progress.dart';
import '../entities/task_solution.dart';
import '../services/path_finder.dart';

/// Розв'язує завдання по черзі та після кожного повідомляє про прогрес.
class SolveTasks {
  final PathFinder _pathFinder;

  const SolveTasks(this._pathFinder);

  Stream<SolvingProgress> call(List<GridTask> tasks) async* {
    final solutions = <TaskSolution>[];
    yield SolvingProgress(total: tasks.length, solutions: const []);

    for (final task in tasks) {
      // віддаємо керування event loop, щоб UI встиг перемалювати прогрес
      await Future<void>.delayed(Duration.zero);

      final steps = _pathFinder.findPath(task.field, task.start, task.end);
      solutions.add(TaskSolution(task: task, steps: steps));

      yield SolvingProgress(
        total: tasks.length,
        solutions: List.unmodifiable(solutions),
      );
    }
  }
}
