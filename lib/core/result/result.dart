import '../error/failures.dart';

/// Результат операції: або дані, або помилка.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

final class Fail<T> extends Result<T> {
  final Failure failure;

  const Fail(this.failure);
}
