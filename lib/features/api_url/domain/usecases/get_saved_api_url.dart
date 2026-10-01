import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/api_url_repository.dart';

/// Повертає останній збережений url для автозаповнення поля.
class GetSavedApiUrl implements UseCase<String?, NoParams> {
  final ApiUrlRepository _repository;

  const GetSavedApiUrl(this._repository);

  @override
  Future<Result<String?>> call(NoParams params) => _repository.getSavedUrl();
}
