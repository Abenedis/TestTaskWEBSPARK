import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/core/error/failures.dart';
import 'package:test_task/core/result/result.dart';
import 'package:test_task/features/path_finder/domain/entities/coordinate.dart';
import 'package:test_task/features/path_finder/domain/entities/grid_field.dart';
import 'package:test_task/features/path_finder/domain/entities/grid_task.dart';
import 'package:test_task/features/path_finder/domain/entities/task_solution.dart';
import 'package:test_task/features/path_finder/domain/repositories/tasks_repository.dart';
import 'package:test_task/features/path_finder/domain/services/bfs_path_finder.dart';
import 'package:test_task/features/path_finder/domain/usecases/fetch_tasks.dart';
import 'package:test_task/features/path_finder/domain/usecases/send_solutions.dart';
import 'package:test_task/features/path_finder/domain/usecases/solve_tasks.dart';
import 'package:test_task/features/path_finder/presentation/bloc/process_bloc.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

void main() {
  const url = 'https://flutter.webspark.dev/flutter/api';
  const task = GridTask(
    id: '1',
    field: GridField(['..', '..']),
    start: Coordinate(0, 0),
    end: Coordinate(1, 1),
  );

  late MockTasksRepository repository;

  ProcessBloc buildBloc() => ProcessBloc(
    apiUrl: url,
    fetchTasks: FetchTasks(repository),
    solveTasks: const SolveTasks(BfsPathFinder()),
    sendSolutions: SendSolutions(repository),
  );

  setUpAll(() => registerFallbackValue(<TaskSolution>[]));
  setUp(() => repository = MockTasksRepository());

  blocTest<ProcessBloc, ProcessState>(
    'після завантаження розраховує всі завдання до 100%',
    setUp: () => when(
      () => repository.fetchTasks(url),
    ).thenAnswer((_) async => const Success([task])),
    build: buildBloc,
    act: (bloc) => bloc.add(const ProcessStarted()),
    wait: const Duration(milliseconds: 50),
    verify: (bloc) {
      expect(bloc.state.status, ProcessStatus.calculated);
      expect(bloc.state.percent, 100);
      expect(bloc.state.solutions.single.path, '(0.0)->(1.1)');
    },
  );

  blocTest<ProcessBloc, ProcessState>(
    'показує помилку, якщо сервер недоступний',
    setUp: () => when(
      () => repository.fetchTasks(url),
    ).thenAnswer((_) async => const Fail(NetworkFailure())),
    build: buildBloc,
    act: (bloc) => bloc.add(const ProcessStarted()),
    expect: () => [
      const ProcessState(),
      const ProcessState(
        status: ProcessStatus.failure,
        errorMessage: 'No internet connection',
      ),
    ],
  );

  blocTest<ProcessBloc, ProcessState>(
    'після невдалого надсилання кнопка знову стає доступною',
    setUp: () => when(
      () => repository.sendSolutions(url, any()),
    ).thenAnswer((_) async => const Fail(ServerFailure('Bad request'))),
    build: buildBloc,
    seed: () =>
        const ProcessState(status: ProcessStatus.calculated, percent: 100),
    act: (bloc) => bloc.add(const ResultsSendRequested()),
    expect: () => [
      const ProcessState(status: ProcessStatus.sending, percent: 100),
      const ProcessState(
        status: ProcessStatus.calculated,
        percent: 100,
        errorMessage: 'Bad request',
      ),
    ],
  );
}
