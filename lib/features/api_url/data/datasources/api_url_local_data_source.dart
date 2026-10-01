import 'package:shared_preferences/shared_preferences.dart';

/// Локальне сховище url на базі SharedPreferences.
abstract class ApiUrlLocalDataSource {
  Future<void> saveUrl(String url);

  String? getUrl();
}

class ApiUrlLocalDataSourceImpl implements ApiUrlLocalDataSource {
  static const _urlKey = 'api_url';

  final SharedPreferences _prefs;

  const ApiUrlLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveUrl(String url) async {
    final saved = await _prefs.setString(_urlKey, url);
    if (!saved) throw Exception('Unable to save url');
  }

  @override
  String? getUrl() => _prefs.getString(_urlKey);
}
