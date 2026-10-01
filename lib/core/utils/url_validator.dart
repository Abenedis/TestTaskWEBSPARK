class UrlValidator {
  const UrlValidator();

  static const _allowedSchemes = {'http', 'https'};

  /// Перевіряє, що рядок є абсолютним http(s) посиланням з хостом.
  /// GET-параметри допускаються.
  bool isValid(String? value) {
    if (value == null || value.trim().isEmpty) return false;

    final uri = Uri.tryParse(value.trim());
    if (uri == null) return false;

    return _allowedSchemes.contains(uri.scheme) && uri.host.isNotEmpty;
  }
}
