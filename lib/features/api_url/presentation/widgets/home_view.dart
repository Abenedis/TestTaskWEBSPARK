import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/loading_button.dart';
import '../cubit/api_url_cubit.dart';
import 'url_input_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStateChanged(BuildContext context, ApiUrlState state) {
    if (state.status == ApiUrlStatus.saved) {
      Navigator.of(
        context,
      ).pushNamed(AppRoutes.process, arguments: state.savedUrl);
      return;
    }
    // заповнюємо поле збереженим url лише якщо користувач ще нічого не ввів
    if (_controller.text.isEmpty && state.savedUrl.isNotEmpty) {
      _controller.text = state.savedUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApiUrlCubit>();

    return BlocConsumer<ApiUrlCubit, ApiUrlState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Set valid API base URL in order to continue'),
              const SizedBox(height: 16),
              UrlInputField(
                controller: _controller,
                errorText: state.errorMessage,
                onChanged: (_) => cubit.clearError(),
                onSubmitted: cubit.submit,
              ),
              const Spacer(),
              LoadingButton(
                label: 'Start counting process',
                isLoading: state.isSaving,
                onPressed: () => cubit.submit(_controller.text),
              ),
            ],
          ),
        );
      },
    );
  }
}
