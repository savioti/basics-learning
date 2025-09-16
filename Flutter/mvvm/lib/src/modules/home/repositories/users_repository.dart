import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:study_flutter_mvvm/src/core/env.dart';
import 'package:study_flutter_mvvm/src/core/error/exception.dart';
import 'package:study_flutter_mvvm/src/core/error/failure.dart';
import 'package:http/http.dart' as http;
import 'package:study_flutter_mvvm/src/modules/home/model/user_model.dart';

class UsersRepository {
  Future<Either<ServerFailure, List<UserModel>>> getUsers() async {
    try {
      final response = await _retrieveUsers();

      if (response.statusCode != 200) {
        return Left(ServerFailure(error: 'Could not connect to server'));
      }

      final users = _extractUsers(response);
      return Right(users);
    } on ServerException {
      return Left(ServerFailure(error: 'Could not connect to server.'));
    } on ConversionException {
      return Left(ServerFailure(error: 'Error while parsing data.'));
    }
  }

  Future<http.Response> _retrieveUsers() async {
    try {
      final uri = Uri.parse('${Env.baseUrl}${Env.usersEndpoint}');
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw ServerException();
      }

      return response;
    } catch (_) {
      throw ServerException();
    }
  }

  List<UserModel> _extractUsers(http.Response response) {
    try {
      final responseBody = jsonDecode(response.body);
      final usersData = responseBody as List;
      final users = usersData.map((e) => UserModel.fromJson(e));
      return users.toList();
    } catch (_) {
      throw ConversionException();
    }
  }
}
