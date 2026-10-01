import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/api_url/data/datasources/api_url_local_data_source.dart';
import '../../features/api_url/data/repositories/api_url_repository_impl.dart';
import '../../features/api_url/domain/repositories/api_url_repository.dart';
import '../../features/api_url/domain/usecases/get_saved_api_url.dart';
import '../../features/api_url/domain/usecases/save_api_url.dart';
import '../../features/api_url/presentation/cubit/api_url_cubit.dart';
import '../../features/path_finder/data/datasources/tasks_remote_data_source.dart';
import '../../features/path_finder/data/repositories/tasks_repository_impl.dart';
import '../../features/path_finder/domain/repositories/tasks_repository.dart';
import '../../features/path_finder/domain/services/bfs_path_finder.dart';
import '../../features/path_finder/domain/services/path_finder.dart';
import '../../features/path_finder/domain/usecases/fetch_tasks.dart';
import '../../features/path_finder/domain/usecases/send_solutions.dart';
import '../../features/path_finder/domain/usecases/solve_tasks.dart';
import '../../features/path_finder/presentation/bloc/process_bloc.dart';

final sl = GetIt.instance;

/// Реєструє залежності. Сервіси — singleton, bloc/cubit — factory,
/// бо кожен екран отримує новий екземпляр.
Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<SharedPreferences>(() => prefs)
    ..registerLazySingleton<http.Client>(http.Client.new);

  _initApiUrl();
  _initPathFinder();
}

void _initApiUrl() {
  sl
    ..registerLazySingleton<ApiUrlLocalDataSource>(
      () => ApiUrlLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<ApiUrlRepository>(() => ApiUrlRepositoryImpl(sl()))
    ..registerLazySingleton(() => SaveApiUrl(sl()))
    ..registerLazySingleton(() => GetSavedApiUrl(sl()))
    ..registerFactory(
      () => ApiUrlCubit(saveApiUrl: sl(), getSavedApiUrl: sl()),
    );
}

void _initPathFinder() {
  sl
    ..registerLazySingleton<TasksRemoteDataSource>(
      () => TasksRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(sl()))
    ..registerLazySingleton<PathFinder>(() => const BfsPathFinder())
    ..registerLazySingleton(() => FetchTasks(sl()))
    ..registerLazySingleton(() => SolveTasks(sl()))
    ..registerLazySingleton(() => SendSolutions(sl()))
    // url передається з екрану введення, тому блок створюється з параметром
    ..registerFactoryParam<ProcessBloc, String, void>(
      (apiUrl, _) => ProcessBloc(
        apiUrl: apiUrl,
        fetchTasks: sl(),
        solveTasks: sl(),
        sendSolutions: sl(),
      ),
    );
}
