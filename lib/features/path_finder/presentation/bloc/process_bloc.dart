import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/grid_task.dart';
import '../../domain/entities/solving_progress.dart';
import '../../domain/entities/task_solution.dart';
import '../../domain/usecases/fetch_tasks.dart';
import '../../domain/usecases/send_solutions.dart';
import '../../domain/usecases/solve_tasks.dart';

part 'process_event.dart';
part 'process_state.dart';

/// Керує екраном процесу: завантаження завдань -> розрахунок -> відправка.
class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  final String _apiUrl;
  final FetchTasks _fetchTasks;
  final SolveTasks _solveTasks;
  final SendSolutions _sendSolutions;

  ProcessBloc({
    required String apiUrl,
    required FetchTasks fetchTasks,
    required SolveTasks solveTasks,
    required SendSolutions sendSolutions,
  }) : _apiUrl = apiUrl,
       _fetchTasks = fetchTasks,
       _solveTasks = solveTasks,
       _sendSolutions = sendSolutions,
       super(const ProcessState()) {
    on<ProcessStarted>(_onStarted);
    on<ResultsSendRequested>(_onSendRequested);
  }

  Future<void> _onStarted(
    ProcessStarted event,
    Emitter<ProcessState> emit,
  ) async {
    emit(const ProcessState());

    final result = await _fetchTasks(_apiUrl);
    switch (result) {
      case Fail(:final failure):
        emit(
          state.copyWith(
            status: ProcessStatus.failure,
            errorMessage: failure.message,
          ),
        );
      case Success(:final data):
        await _calculate(data, emit);
    }
  }

  /// Кожне значення стріму оновлює відсоток виконання на екрані.
  Future<void> _calculate(List<GridTask> tasks, Emitter<ProcessState> emit) {
    return emit.forEach<SolvingProgress>(
      _solveTasks(tasks),
      onData: (progress) => state.copyWith(
        status: progress.isCompleted
            ? ProcessStatus.calculated
            : ProcessStatus.calculating,
        percent: progress.percent,
        solutions: progress.solutions,
      ),
    );
  }

  Future<void> _onSendRequested(
    ResultsSendRequested event,
    Emitter<ProcessState> emit,
  ) async {
    // захист від повторного натискання під час відправки
    if (state.status != ProcessStatus.calculated) return;

    emit(state.copyWith(status: ProcessStatus.sending));

    final result = await _sendSolutions(
      SendSolutionsParams(url: _apiUrl, solutions: state.solutions),
    );
    switch (result) {
      case Success():
        emit(state.copyWith(status: ProcessStatus.sent));
      case Fail(:final failure):
        // повертаємо кнопку в активний стан і показуємо причину
        emit(
          state.copyWith(
            status: ProcessStatus.calculated,
            errorMessage: failure.message,
          ),
        );
    }
  }
}
