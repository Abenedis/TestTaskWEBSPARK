import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_routes.dart';
import '../../bloc/process_bloc.dart';
import 'process_actions.dart';
import 'process_progress.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  /// Після успішної відправки замінюємо екран процесу списком результатів,
  /// щоб кнопка «назад» вела одразу на головний екран.
  void _onStateChanged(BuildContext context, ProcessState state) {
    if (state.status != ProcessStatus.sent) return;

    Navigator.of(
      context,
    ).pushReplacementNamed(AppRoutes.results, arguments: state.solutions);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProcessBloc, ProcessState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _onStateChanged,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: ProcessProgress(state: state)),
              ProcessActions(state: state),
            ],
          ),
        );
      },
    );
  }
}
