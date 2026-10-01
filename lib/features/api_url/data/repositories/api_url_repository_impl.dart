import '../../../../core/error/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/repositories/api_url_repository.dart';
import '../datasources/api_url_local_data_source.dart';

class ApiUrlRepositoryImpl implements ApiUrlRepository {
  final ApiUrlLocalDataSource _localDataSource;

  const ApiUrlRepositoryImpl(this._localDataSource);

  @override
  Future<Result<void>> saveUrl(String url) async {
    try {
      await _localDataSource.saveUrl(url);
      return const Success(null);
    } catch (_) {
      return const Fail(CacheFailure());
    }
  }

  @override
  Future<Result<String?>> getSavedUrl() async {
    try {
      return Success(_localDataSource.getUrl());
    } catch (_) {
      return const Fail(CacheFailure());
    }
  }
}
