import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../cubit/api_url_cubit.dart';
import '../widgets/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ApiUrlCubit>()..loadSavedUrl(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home screen')),
        body: const SafeArea(child: HomeView()),
      ),
    );
  }
}
