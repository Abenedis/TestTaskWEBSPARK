import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/grid_task.dart';
import '../../domain/entities/task_solution.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_remote_data_source.dart';
import '../models/task_solution_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _remoteDataSource;

  const TasksRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<GridTask>>> fetchTasks(String url) {
    return _guard(() => _remoteDataSource.getTasks(url));
  }

  @override
  Future<Result<void>> sendSolutions(String url, List<TaskSolution> solutions) {
    final models = solutions.map(TaskSolutionModel.new).toList();
    return _guard(() => _remoteDataSource.postSolutions(url, models));
  }

  /// Перетворює винятки рівня даних на зрозумілі для домену помилки.
  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } on ServerException catch (e) {
      return Fail(ServerFailure(e.message));
    } on NetworkException {
      return const Fail(NetworkFailure());
    } catch (_) {
      return const Fail(ServerFailure('Unable to process server response'));
    }
  }
}
