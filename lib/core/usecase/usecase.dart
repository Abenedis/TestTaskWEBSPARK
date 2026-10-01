import '../result/result.dart';

/// Спільний контракт для всіх асинхронних сценаріїв.
abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams {
  const NoParams();
}
