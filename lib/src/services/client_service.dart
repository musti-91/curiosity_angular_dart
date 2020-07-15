import 'dart:async';

import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:http/http.dart';
import 'package:viewer/src/model/Course.dart';
import 'package:viewer/src/utils/helpers.dart';

@Injectable()
class ClientService {
  final Client _client;
  static const _baseURL = 'api/courses';
  static final _headers = {'Content-Type': "application/json"};

  ClientService(this._client);

  Future<List<Course>> getAll() async {
    try {
      final res = await _client.get('courses', headers: _headers);
      final courses = (Helper.extractData(res) as List)
          .map((json) => Course.fromJson(json))
          .toList();

      return courses;
    } catch (e) {
      throw Helper.simplifyError(e);
    }
  }

  // ignore: missing_return
  Future<Course> getSingle(String uid) async {
    try {
      final res = await _client.get('$_baseURL/$uid');
      return Course.fromJson(Helper.extractData(res));
    } catch (e) {
      Helper.simplifyError(e);
    }
  }

  // ignore: missing_return
  Future<Course> createCourse(String title) async {
    try {
      final resp = await _client.post(
        _baseURL,
        headers: _headers,
        body: json.encode({'title': title}),
      );

      return Course.fromJson(Helper.extractData(resp));
    } catch (e) {
      Helper.simplifyError(e);
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      final url = '$_baseURL/$id';
      await _client.delete(url, headers: _headers);
    } catch (e) {
      Helper.simplifyError(e);
    }
  }

  // ignore: missing_return
  Future<Course> updateCourse(Course course) async {
    try {
      final url = '$_baseURL/${course.uid}';
      final resp = await _client.put(
        url,
        headers: _headers,
        body: json.encode(course),
      );
      return Course.fromJson(Helper.extractData(resp));
    } catch (e) {
      Helper.simplifyError(e);
    }
  }

  // ignore: missing_return
  Future<List<Course>> search(String term) async {
    try {
      final res = await _client.get('api/courses/?title=$term');
      return (Helper.extractData(res) as List)
          .map((json) => Course.fromJson(json))
          .toList();
    } catch (e) {
      Helper.simplifyError(e);
    }
  }
}
