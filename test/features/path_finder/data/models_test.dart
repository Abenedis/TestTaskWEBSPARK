import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/features/path_finder/data/models/grid_task_model.dart';
import 'package:test_task/features/path_finder/data/models/task_solution_model.dart';
import 'package:test_task/features/path_finder/domain/entities/coordinate.dart';
import 'package:test_task/features/path_finder/domain/entities/task_solution.dart';

void main() {
  final json = {
    'id': 'task-1',
    'field': ['.X.', '.X.', '...'],
    'start': {'x': 2, 'y': 1},
    'end': {'x': 0, 'y': 2},
  };

  test('GridTaskModel розбирає відповідь API', () {
    final task = GridTaskModel.fromJson(json);

    expect(task.id, 'task-1');
    expect(task.field.width, 3);
    expect(task.start, const Coordinate(2, 1));
    expect(task.end, const Coordinate(0, 2));
  });

  test('TaskSolutionModel формує тіло POST-запиту', () {
    final solution = TaskSolution(
      task: GridTaskModel.fromJson(json),
      steps: const [Coordinate(2, 1), Coordinate(1, 2), Coordinate(0, 2)],
    );

    expect(TaskSolutionModel(solution).toJson(), {
      'id': 'task-1',
      'result': {
        'steps': [
          {'x': 2, 'y': 1},
          {'x': 1, 'y': 2},
          {'x': 0, 'y': 2},
        ],
        'path': '(2.1)->(1.2)->(0.2)',
      },
    });
  });
}
