import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knowunity_todo_app/core/error/exceptions.dart';
import 'package:knowunity_todo_app/core/util/messages.dart';
import 'package:knowunity_todo_app/feature/model/reponse/todo_response.dart';

abstract interface class TodoRemoteDatasource {
  Future<List<TodoResponse>> getAllTasks();
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final http.Client _client;

  const TodoRemoteDatasourceImpl(this._client);

  @override
  Future<List<TodoResponse>> getAllTasks() async {
    final response = await _client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: {'Content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data
          .map<TodoResponse>((json) => TodoResponse.fromJson(json))
          .toList();
    }

    throw const ServerException(serverError);
  }
}
