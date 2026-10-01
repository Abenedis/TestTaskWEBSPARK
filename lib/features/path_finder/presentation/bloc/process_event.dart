part of 'process_bloc.dart';

sealed class ProcessEvent extends Equatable {
  const ProcessEvent();

  @override
  List<Object?> get props => [];
}

/// Старт або повторна спроба завантаження й розрахунку.
final class ProcessStarted extends ProcessEvent {
  const ProcessStarted();
}

/// Натискання кнопки «Send results to server».
final class ResultsSendRequested extends ProcessEvent {
  const ResultsSendRequested();
}
