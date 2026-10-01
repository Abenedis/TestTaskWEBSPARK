import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/grid_task.dart';
import '../models/grid_task_model.dart';
import '../models/task_solution_model.dart';

/// Робота з REST API. Кидає [ServerException] або [NetworkException].
abstract class TasksRemoteDataSource {
  Future<List<GridTask>> getTasks(String url);

  Future<void> postSolutions(String url, List<TaskSolutionModel> solutions);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  static const _timeout = Duration(seconds: 20);
  static const _jsonHeaders = {'Content-Type': 'application/json'};

  final http.Client _client;

  const TasksRemoteDataSourceImpl(this._client);

  @override
  Future<List<GridTask>> getTasks(String url) async {
    final body = await _send(() => _client.get(Uri.parse(url)));
    final data = body['data'] as List? ?? const [];

    return data
        .map((e) => GridTaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> postSolutions(
    String url,
    List<TaskSolutionModel> solutions,
  ) async {
    final payload = jsonEncode(solutions.map((s) => s.toJson()).toList());
    await _send(
      () => _client.post(Uri.parse(url), headers: _jsonHeaders, body: payload),
    );
  }

  /// Виконує запит і зводить мережеві помилки та таймаут до [NetworkException].
  Future<Map<String, dynamic>> _send(
    Future<http.Response> Function() request,
  ) async {
    final http.Response response;
    try {
      response = await request().timeout(_timeout);
    } on TimeoutException {
      throw const NetworkException();
    } on http.ClientException {
      throw const NetworkException();
    }
    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } on FormatException {
      throw ServerException('Unexpected response (${response.statusCode})');
    }

    // API може повернути 200, але з прапорцем error у тілі
    final hasError = body['error'] == true;
    if (response.statusCode != 200 || hasError) {
      final message = body['message'] as String? ?? 'Server error';
      throw ServerException(message);
    }
    return body;
  }
}
