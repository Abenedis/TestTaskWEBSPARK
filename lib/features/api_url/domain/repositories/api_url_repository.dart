import '../../../../core/result/result.dart';

/// Контракт збереження url API між запусками застосунку.
abstract class ApiUrlRepository {
  Future<Result<void>> saveUrl(String url);

  /// Повертає null, якщо url ще ніколи не зберігався.
  Future<Result<String?>> getSavedUrl();
}
