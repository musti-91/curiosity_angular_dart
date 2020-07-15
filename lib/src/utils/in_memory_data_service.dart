import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:uuid/uuid.dart';
import 'package:viewer/src/model/Course.dart';

class InMemoryDataService extends MockClient {
  static final uuid = Uuid();
  static final _initialCoursees = [
    {'uid': 'flkqsnflkn-fndslnq-11', 'title': 'Mr. Nice'},
    {'uid': 'flkqsnflkn-fndslnq-12', 'title': 'Narco'},
    {'uid': 'flkqsnflkn-fndslnq-13', 'title': 'Bombasto'},
    {'uid': 'flkqsnflkn-fndslnq-14', 'title': 'Celeritas'},
    {'uid': 'flkqsnflkn-fndslnq-15', 'title': 'Magneta'},
    {'uid': 'flkqsnflkn-fndslnq-16', 'title': 'RubberMan'},
    {'uid': 'flkqsnflkn-fndslnq-17', 'title': 'Dynama'},
    {'uid': 'flkqsnflkn-fndslnq-18', 'title': 'Dr IQ'},
    {'uid': 'flkqsnflkn-fndslnq-19', 'title': 'Magma'},
    {'uid': 'flkqsnflkn-fndslnq-20', 'title': 'Tornado'}
  ];
  static List<Course> _coursesDB;
  static Future<Response> _handler(Request request) async {
    if (_coursesDB == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
        final uid = request.url.pathSegments.last;
        if (uid != null && uid != "courses") {
          data = _coursesDB
              // throws if no match
              .firstWhere((course) => course.uid == uid);
        } else {
          String prefix = request.url.queryParameters['title'] ?? '';
          final regExp = RegExp(prefix, caseSensitive: false);
          data = _coursesDB
              .where((course) => course.title.contains(regExp))
              .toList();
        }
        break;
      case 'POST':
        var title = json.decode(request.body)['title'];
        var newCourse = Course(uuid.v4(), title);
        _coursesDB.add(newCourse);
        data = newCourse;
        break;
      case 'PUT':
        var coursesChanges = Course.fromJson(json.decode(request.body));
        var targetCourse =
            _coursesDB.firstWhere((h) => h.uid == coursesChanges.uid);
        targetCourse.title = coursesChanges.title;
        data = targetCourse;
        break;
      case 'DELETE':
        var uid = request.url.pathSegments.last;
        _coursesDB.removeWhere((course) => course.uid == uid);
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }

  static resetDb() {
    _coursesDB = _initialCoursees.map((json) => Course.fromJson(json)).toList();
  }

  static String lookUpTitle(String uid) {
    return _coursesDB.firstWhere((course) => course.uid == uid)?.title;
  }

  InMemoryDataService() : super(_handler);
}
