import 'package:angular_router/angular_router.dart';

final idParam = 'id';

class RoutePaths {
  static final courses = RoutePath(path: 'courses');
  static final course = RoutePath(path: '${courses.path}/:$idParam');
}

String getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : id;
}
