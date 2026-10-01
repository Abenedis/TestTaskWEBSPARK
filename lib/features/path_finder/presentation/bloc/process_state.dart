part of 'process_bloc.dart';

/// Етапи екрану процесу. [failure] — лише помилка завантаження завдань,
/// помилка відправки повертає стан у [calculated] з текстом помилки.
enum ProcessStatus { loading, calculating, calculated, sending, sent, failure }

class ProcessState extends Equatable {
  final ProcessStatus status;
  final int percent;
  final List<TaskSolution> solutions;
  final String? errorMessage;

  const ProcessState({
    this.status = ProcessStatus.loading,
    this.percent = 0,
    this.solutions = const [],
    this.errorMessage,
  });

  bool get isCalculationFinished =>
      status == ProcessStatus.calculated || status == ProcessStatus.sending;

  bool get isSending => status == ProcessStatus.sending;

  // errorMessage не копіюється, щоб старе повідомлення зникало з новим станом
  ProcessState copyWith({
    ProcessStatus? status,
    int? percent,
    List<TaskSolution>? solutions,
    String? errorMessage,
  }) {
    return ProcessState(
      status: status ?? this.status,
      percent: percent ?? this.percent,
      solutions: solutions ?? this.solutions,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, percent, solutions, errorMessage];
}
