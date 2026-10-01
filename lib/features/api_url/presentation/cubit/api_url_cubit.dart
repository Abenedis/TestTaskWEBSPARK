import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/url_validator.dart';
import '../../domain/usecases/get_saved_api_url.dart';
import '../../domain/usecases/save_api_url.dart';

part 'api_url_state.dart';

/// Логіка екрану введення url: валідація та збереження.
class ApiUrlCubit extends Cubit<ApiUrlState> {
  final SaveApiUrl _saveApiUrl;
  final GetSavedApiUrl _getSavedApiUrl;
  final UrlValidator _validator;

  ApiUrlCubit({
    required SaveApiUrl saveApiUrl,
    required GetSavedApiUrl getSavedApiUrl,
    UrlValidator validator = const UrlValidator(),
  }) : _saveApiUrl = saveApiUrl,
       _getSavedApiUrl = getSavedApiUrl,
       _validator = validator,
       super(const ApiUrlState());

  /// Підставляє останній збережений url, щоб не вводити його щоразу.
  Future<void> loadSavedUrl() async {
    final result = await _getSavedApiUrl(const NoParams());
    if (result case Success(data: final url?)) {
      emit(state.copyWith(savedUrl: url));
    }
  }

  /// Перевіряє url і зберігає його. Після успіху стан [ApiUrlStatus.saved]
  /// є сигналом для переходу на екран процесу.
  Future<void> submit(String url) async {
    if (!_validator.isValid(url)) {
      emit(
        state.copyWith(
          status: ApiUrlStatus.failure,
          errorMessage: 'Please enter a valid URL',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ApiUrlStatus.saving));

    final result = await _saveApiUrl(url);
    switch (result) {
      case Success():
        emit(state.copyWith(status: ApiUrlStatus.saved, savedUrl: url.trim()));
      case Fail(:final failure):
        emit(
          state.copyWith(
            status: ApiUrlStatus.failure,
            errorMessage: failure.message,
          ),
        );
    }
  }

  /// Прибирає помилку, щойно користувач почав виправляти url.
  void clearError() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(status: ApiUrlStatus.initial));
  }
}
