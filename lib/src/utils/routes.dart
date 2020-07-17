import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';

import '../courses/courses_component.template.dart' as courses_template;
import '../courses/course_detail_component.template.dart'
    as course_detail_template;

export 'route_paths.dart';

class Routes {
  static final courses = RouteDefinition(
    routePath: RoutePaths.courses,
    component: courses_template.CoursesListNgFactory,
  );

  static final course = RouteDefinition(
    routePath: RoutePaths.course,
    component: course_detail_template.CourseDetailNgFactory,
  );

  static final all = <RouteDefinition>[
    courses,
    course,
    RouteDefinition.redirect(
      // this should be changed to home page.
      // since we don't have Home page redirect it to our courses page.
      path: '/',
      redirectTo: RoutePaths.courses.toUrl(),
    )
  ];
}
