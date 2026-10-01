import 'package:flutter/material.dart';

import '../../bloc/process_bloc.dart';

class ProcessProgress extends StatelessWidget {
  final ProcessState state;

  const ProcessProgress({super.key, required this.state});

  String get _message => switch (state.status) {
    ProcessStatus.loading => 'Fetching tasks from server...',
    ProcessStatus.calculating => 'Calculating shortest paths...',
    ProcessStatus.failure => 'Unable to fetch tasks',
    _ => 'All calculations has finished, you can send your results to server',
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLoading = state.status == ProcessStatus.loading;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('${state.percent}%', style: textTheme.headlineMedium),
          const SizedBox(height: 16),
          SizedBox.square(
            dimension: 64,
            child: CircularProgressIndicator(
              // поки завдання не отримані, показуємо невизначений прогрес
              value: isLoading ? null : state.percent / 100,
              strokeWidth: 6,
            ),
          ),
        ],
      ),
    );
  }
}
