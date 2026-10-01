import 'package:flutter/material.dart';

import '../../features/api_url/presentation/pages/home_page.dart';
import '../../features/path_finder/domain/entities/task_solution.dart';
import '../../features/path_finder/presentation/pages/preview_page.dart';
import '../../features/path_finder/presentation/pages/process_page.dart';
import '../../features/path_finder/presentation/pages/results_page.dart';
import 'app_routes.dart';

/// Створює сторінки за назвою маршруту. Дані між екранами передаються через arguments.
abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    final Widget page = switch (settings.name) {
      AppRoutes.process => ProcessPage(apiUrl: args as String),
      AppRoutes.results => ResultsPage(solutions: args as List<TaskSolution>),
      AppRoutes.preview => PreviewPage(solution: args as TaskSolution),
      _ => const HomePage(),
    };

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
