import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/loading_button.dart';
import '../../bloc/process_bloc.dart';

/// Нижня частина екрану: текст помилки та доступна дія.
class ProcessActions extends StatelessWidget {
  final ProcessState state;

  const ProcessActions({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProcessBloc>();
    final error = state.errorMessage;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (error != null) ...[
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 12),
        ],
        if (state.isCalculationFinished)
          LoadingButton(
            label: 'Send results to server',
            isLoading: state.isSending,
            onPressed: () => bloc.add(const ResultsSendRequested()),
          )
        else if (state.status == ProcessStatus.failure)
          ElevatedButton(
            onPressed: () => bloc.add(const ProcessStarted()),
            child: const Text('Try again'),
          ),
      ],
    );
  }
}
