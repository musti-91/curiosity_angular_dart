import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:uuid/uuid.dart';
import 'package:viewer/src/model/Course.dart';

class InMemoryDataService extends MockClient {
  static final _initialCourses = [
    {'uid': 'fksqfksd-fklnsqfn-1', 'title': 'Dart the complete guide'},
    {'uid': 'fksqfksd-fklnsqfn-2', 'title': 'Javascript tutorials'},
    {'uid': 'fksqfksd-fklnsqfn-3', 'title': 'Typescript'},
    {'uid': 'fksqfksd-fklnsqfn-4', 'title': 'AngularDart 0 to hero'},
    {'uid': 'fksqfksd-fklnsqfn-5', 'title': 'RxDart the ulimate course'},
  ];

  static List<Course> _coursesDb;
  static int _nextId;

  static Future<Response> _handler(Request req) async {
    if (_coursesDb == null) resetDb();
    var uuid = Uuid();
    var data;

    switch (req.method) {
      case 'GET':
        final uid = req.url.pathSegments.last;
        if (uid != null) {
          data = _coursesDb
              .firstWhere((cr) => cr.uid == uid); // throws if no match
        } else {
          var prefix = req.url.queryParameters['title'] ?? '';
          final regExp = RegExp(prefix, caseSensitive: false);
          data = _coursesDb.where((cr) => cr.title.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var title = jsonDecode(req.body)['title'];
        var newCourse = Course(uuid.v1(), title);

        _coursesDb.add(newCourse);
        data = newCourse;
        break;

      case 'PUT':
        var courseChanges = Course.fromJson(jsonDecode(req.body));
        var targetCourse = _coursesDb.firstWhere(
          (element) => element.uid == courseChanges.uid,
        );

        targetCourse.title = courseChanges.title;
        data = targetCourse;
        break;

      case 'DELETE':
        var uid = req.url.pathSegments.last;
        _coursesDb.removeWhere((course) => course.uid == uid);
        break;

      default:
        throw 'Unimplemented HTTP method ${req.method}';
    }

    return Response(
      jsonEncode({'data': data}),
      200,
      headers: {'Content-Type': 'application/json'},
    );
  }

  static resetDb() {
    _coursesDb = _initialCourses
        .map(
          (json) => Course.fromJson(json),
        )
        .toList();
    // _nextId =
    //     _coursesDb.map((course) => course.uid).elementAt(_coursesDb.length);
  }

  static String loolUpTitle(String uid) =>
      _coursesDb.firstWhere((course) => course.uid == uid)?.title;
  InMemoryDataService() : super(_handler);
}
