import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:viewer/src/courses/course_service.dart';
import 'package:viewer/src/model/Course.dart';
import 'package:viewer/src/utils/helpers.dart';
import 'package:viewer/src/utils/routes.dart';

@Component(
  selector: 'search-feature',
  templateUrl: "search_template.html",
  directives: [coreDirectives],
  providers: [ClassProvider(CourseService)],
  pipes: [commonPipes],
)
class SearchComponent implements OnInit {
  final CourseService _courseService;
  Router _router;

  SearchComponent(this._courseService, this._router);

  Stream<List<Course>> courses;
  StreamController<String> _searchTerm = StreamController.broadcast();

  void search(String term) => _searchTerm.add(term);

  @override
  void ngOnInit() async {
    courses = _searchTerm.stream
        .transform(debounce(Duration(microseconds: 300)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<Course>>.fromIterable([<Course>[]])
            : _courseService.search(term).asStream()))
        .handleError((e) => Helper.simplifyError(e));
  }

  String _courseURl(String uid) => RoutePaths.course.toUrl(
        parameters: {idParam: '$uid'},
      );

  Future<NavigationResult> gotoDetail(Course course) => _router.navigate(
        _courseURl(course.uid),
      );
}
