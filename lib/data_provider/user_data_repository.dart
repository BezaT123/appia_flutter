import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appia/models/models.dart';

class NoUserException implements Exception {}

class UserDataProvider {
  final _baseUrl = "http://192.168.43.41:8080";
  final http.Client httpClient;

  UserDataProvider({required this.httpClient});

  Future<User> searchUser(String username) async {
    List<String> a = [];
    return User(username, "4");
  }
}
