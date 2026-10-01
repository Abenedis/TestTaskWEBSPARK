import 'package:equatable/equatable.dart';

import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/task_solution.dart';
import '../repositories/tasks_repository.dart';

/// Відправляє всі розраховані шляхи на сервер для перевірки.
class SendSolutions implements UseCase<void, SendSolutionsParams> {
  final TasksRepository _repository;

  const SendSolutions(this._repository);

  @override
  Future<Result<void>> call(SendSolutionsParams params) =>
      _repository.sendSolutions(params.url, params.solutions);
}

class SendSolutionsParams extends Equatable {
  final String url;
  final List<TaskSolution> solutions;

  const SendSolutionsParams({required this.url, required this.solutions});

  @override
  List<Object?> get props => [url, solutions];
}
