import 'package:angular_router/angular_router.dart';

final uid = 'uid';

class RoutePaths {
  static final courses = RoutePath(path: 'courses');
  static final course = RoutePath(path: '${courses.path}/:$uid');
}

String getId(Map<String, String> routeParams) => routeParams['uid'] ?? '';
