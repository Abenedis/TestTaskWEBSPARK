import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/api_url_repository.dart';

/// Зберігає url, введений користувачем. Пробіли по краях відкидаються.
class SaveApiUrl implements UseCase<void, String> {
  final ApiUrlRepository _repository;

  const SaveApiUrl(this._repository);

  @override
  Future<Result<void>> call(String url) => _repository.saveUrl(url.trim());
}
