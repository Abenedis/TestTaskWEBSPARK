part of 'api_url_cubit.dart';

enum ApiUrlStatus { initial, saving, saved, failure }

class ApiUrlState extends Equatable {
  final ApiUrlStatus status;
  final String savedUrl;
  final String? errorMessage;

  const ApiUrlState({
    this.status = ApiUrlStatus.initial,
    this.savedUrl = '',
    this.errorMessage,
  });

  bool get isSaving => status == ApiUrlStatus.saving;

  // errorMessage свідомо не копіюється, щоб помилка зникала при наступній дії
  ApiUrlState copyWith({
    ApiUrlStatus? status,
    String? savedUrl,
    String? errorMessage,
  }) {
    return ApiUrlState(
      status: status ?? this.status,
      savedUrl: savedUrl ?? this.savedUrl,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, savedUrl, errorMessage];
}
