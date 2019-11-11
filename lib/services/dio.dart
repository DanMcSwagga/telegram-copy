import 'package:dio/dio.dart';

final Dio dio = new Dio();

Future dioGet(String url) {
  return dio.get(url);
}

Future dioGetContact(id) {
  return dio.get('https://swapi.co/api/people/$id');
}
