import '../../domain/entities/task_solution.dart';
import 'coordinate_model.dart';

/// Обгортка над [TaskSolution] для серіалізації у формат POST-запиту.
class TaskSolutionModel {
  final TaskSolution solution;

  const TaskSolutionModel(this.solution);

  Map<String, dynamic> toJson() {
    return {
      'id': solution.task.id,
      'result': {
        'steps': solution.steps.map(CoordinateModel.toJson).toList(),
        'path': solution.path,
      },
    };
  }
}
