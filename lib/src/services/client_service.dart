import 'dart:async';
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

  Future<Course> getSingle(String uid) async {
    try {
      final res = await _client.get('$_baseURL/$uid');
      return Course.fromJson(Helper.extractData(res));
    } catch (e) {
      Helper.simplifyError(e);
    }
  }
}
