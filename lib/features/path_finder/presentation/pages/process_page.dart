import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/process_bloc.dart';
import '../widgets/process/process_view.dart';

class ProcessPage extends StatelessWidget {
  final String apiUrl;

  const ProcessPage({super.key, required this.apiUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ProcessBloc>(param1: apiUrl)..add(const ProcessStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Process screen')),
        body: const SafeArea(child: ProcessView()),
      ),
    );
  }
}
