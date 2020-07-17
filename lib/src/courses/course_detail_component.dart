import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:curiosity/src/courses/course_service.dart';
import 'package:curiosity/src/model/Course.dart';
import 'package:curiosity/src/utils/routes.dart';

@Component(
  selector: 'course-detail',
  templateUrl: './course_detail_template.html',
  directives: [
    coreDirectives,
    formDirectives,
    routerDirectives,
  ],
  providers: [ClassProvider(CourseService)],
)
class CourseDetail implements OnActivate {
  Course selectedCourse;
  final CourseService _courseService;
  final Location _location;

  CourseDetail(this._courseService, this._location);

  @override
  void onActivate(RouterState previous, RouterState current) async {
    final uid = getId(current.parameters);
    if (uid != null) {
      selectedCourse = await (_courseService.getSingle(uid));
    }
  }

  void goBack() => _location.back();

  Future<void> save() async {
    await _courseService.updateCourse(selectedCourse);
    goBack();
  }
}
