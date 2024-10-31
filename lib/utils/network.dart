import 'dart:async';

import 'package:clmd_flutter/models/report.dart';
import 'package:dio/dio.dart';

class Api {
  static final _dio = Dio();

  static Future<ReportData> postData(String url, Map params, String category) {
    final option = Options();
    option.headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90dzJhcGkueGlpbmhlYWx0aHRlY2guY29tXC9hcGlcL3Y1XC9hdXRoXC9jb2RlXC92ZXJpZnkiLCJpYXQiOjE2NzgxNTYwMzksImV4cCI6MTk5MzUxNjAzOSwibmJmIjoxNjc4MTU2MDM5LCJqdGkiOiJvdWRua0MzNE5KSkg0WFAzIiwic3ViIjo0LCJwcnYiOiJmNmI3MTU0OWRiOGMyYzQyYjc1ODI3YWE0NGYwMmI3ZWU1MjlkMjRkIn0.lwGJjjn3iqsPOCtt04TuVt5eAhR9rHR74vg_zNL7Nsk'
    };

    return _dio.post(url, options: option, data: params).then((value) {
      return ReportData.fromJson(value.data, category);
    });
  }

  static Future post1Data(
      String url, Map<String, dynamic>? headers, Map params) {
    final option = Options();
    // option.headers = {
    //   'Authorization':
    //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90dzJhcGkueGlpbmhlYWx0aHRlY2guY29tXC9hcGlcL3Y1XC9hdXRoXC9jb2RlXC92ZXJpZnkiLCJpYXQiOjE2NzgxNTYwMzksImV4cCI6MTk5MzUxNjAzOSwibmJmIjoxNjc4MTU2MDM5LCJqdGkiOiJvdWRua0MzNE5KSkg0WFAzIiwic3ViIjo0LCJwcnYiOiJmNmI3MTU0OWRiOGMyYzQyYjc1ODI3YWE0NGYwMmI3ZWU1MjlkMjRkIn0.lwGJjjn3iqsPOCtt04TuVt5eAhR9rHR74vg_zNL7Nsk'
    // };
    // headers?['Authorization'] =
    //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90dzJhcGkueGlpbmhlYWx0aHRlY2guY29tXC9hcGlcL3Y1XC9hdXRoXC9jb2RlXC92ZXJpZnkiLCJpYXQiOjE2NzgxNTYwMzksImV4cCI6MTk5MzUxNjAzOSwibmJmIjoxNjc4MTU2MDM5LCJqdGkiOiJvdWRua0MzNE5KSkg0WFAzIiwic3ViIjo0LCJwcnYiOiJmNmI3MTU0OWRiOGMyYzQyYjc1ODI3YWE0NGYwMmI3ZWU1MjlkMjRkIn0.lwGJjjn3iqsPOCtt04TuVt5eAhR9rHR74vg_zNL7Nsk';
    option.headers = headers;
    return _dio.post(url, options: option, data: params).then((value) {
      print(value.data);
    });
  }
}
