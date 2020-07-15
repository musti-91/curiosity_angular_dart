import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:viewer/src/courses/course_service.dart';
import 'package:viewer/src/model/Course.dart';
import 'package:viewer/src/search/search_component.dart';
import 'package:viewer/src/utils/routes.dart';

@Component(
  selector: 'courses',
  templateUrl: './courses_template.html',
  directives: [
    coreDirectives,
    SearchComponent,
  ],
  providers: [
    ClassProvider(CourseService),
  ],
  pipes: [commonPipes],
)
class CoursesList implements OnInit {
  final CourseService _courseService;
  final Router _router;
  List<Course> courses;
  Course selected;
  bool addMode = false;

  CoursesList(this._courseService, this._router);

  @override
  void ngOnInit() => _getCourses();

  Future<void> _getCourses() async {
    courses = await _courseService.getAll();
  }

  void onSelect(Course course) => selected = course;

  Future<void> addCourse(String courseTitle) async {
    if (courseTitle.isEmpty) return null;
    courses.add(await this._courseService.createCourse(courseTitle));
    selected = null;
  }

  Future<void> deleteCourse(Course course) async {
    await _courseService.deleteCourse(course.uid);
    courses.remove(course);
    if (selected == course) selected = null;
  }

  Future<NavigationResult> gotoDetail(Course course) {
    selected = course;
    return _router.navigate(_courseURL(selected.uid));
  }

  String _courseURL(String uid) {
    return RoutePaths.course.toUrl(
      parameters: {idParam: '$uid'},
    );
  }
}
