import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:viewer/src/model/Course.dart';

final tags = <List<String>>[
  ['Javascript'],
  ['Typeccript'],
  ['Angular'],
  ['AngularDart'],
  ['Dart'],
  ['Flutter'],
  ['Firebase'],
  ['NodeJs'],
  ['Graphql'],
  ['Deno'],
];
final titles = <String>[
  'Javascript: the complete guide',
  'Typescript: the complete guide',
  'Learn Angular 4 with Typescript',
  'Dart & Angular = AngularDart is awasome',
  'Learn Dart from google',
  'Learn CPMD with Flutter',
  'Firebase crash course',
  'Create Rest API with NodeJs',
  'Build a full API with Graphql',
  'Learn Deno the new tech',
];
final prices = <double>[
  12.50,
  11.99,
  30.30,
  3.99,
  5.99,
  12.29,
  44.49,
  199.99,
  23.33,
  11.99,
];

class InMemoryDataService extends MockClient {
  static final uuid = Uuid();
  static List<Map<String, dynamic>> _initialCourses() {
    List<Map<String, dynamic>> mockJson = [];
    for (var i = 0; i < 10; i++) {
      mockJson.add({
        'uid': uuid.v4(), // required
        'title': titles[i], // required
        'price': prices[i], // required
        'author': 'Mustafa Alroomi', // required
        'tags': tags[i],
        'image': 'https://bit.ly/2Ov4vSN', // dummy image
        'description': 'course is available',
        'updateAt': DateFormat('dd-MM-yy').format(DateTime.now()),
        'stars': List.generate(5, (index) => index + 1),
        'lectures': 33,
        'totalDuration': 33.33,
      });
    }
    return mockJson;
  }

  static List<Course> _coursesDB;
  static Future<Response> _handler(Request request) async {
    if (_coursesDB == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
        final uid = request.url.pathSegments.last;
        if (uid != null && uid != "courses" && uid.isNotEmpty) {
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
        var initialPrice = json.decode(request.body)['price'];
        var author = json.decode(request.body)['author'];
        var newCourse = Course(uuid.v4(), title, initialPrice, author);
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
    _coursesDB = _initialCourses()
        .map(
          (json) => Course.fromJson(json),
        )
        .toList();
  }

  static String lookUpTitle(String uid) {
    return _coursesDB.firstWhere((course) => course.uid == uid)?.title;
  }

  InMemoryDataService() : super(_handler);
}
