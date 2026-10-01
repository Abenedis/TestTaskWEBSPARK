import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/grid_task.dart';
import '../repositories/tasks_repository.dart';

/// Завантажує завдання для розрахунку за збереженим url.
class FetchTasks implements UseCase<List<GridTask>, String> {
  final TasksRepository _repository;

  const FetchTasks(this._repository);

  @override
  Future<Result<List<GridTask>>> call(String url) =>
      _repository.fetchTasks(url);
}
