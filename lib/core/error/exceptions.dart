/// Винятки рівня даних, які репозиторій перетворює на [Failure].
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  const NetworkException();
}
