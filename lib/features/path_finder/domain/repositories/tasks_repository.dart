import '../../../../core/result/result.dart';
import '../entities/grid_task.dart';
import '../entities/task_solution.dart';

/// Контракт роботи із завданнями. Домен не знає, звідки беруться дані.
abstract class TasksRepository {
  /// Отримує список завдань за GET-запитом на [url].
  Future<Result<List<GridTask>>> fetchTasks(String url);

  /// Надсилає результати розрахунків POST-запитом на той самий [url].
  Future<Result<void>> sendSolutions(String url, List<TaskSolution> solutions);
}
