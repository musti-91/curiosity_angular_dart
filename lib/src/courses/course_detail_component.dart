import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'course-detail',
  // templateUrl: './course_detail_template.html',
  template: '''<h1>course detail</h1>''',
  directives: [coreDirectives],
  providers: [],
)
class CourseDetail implements OnInit {
  @override
  Future<Null> ngOnInit() async {
    // wait for something to finish
  }
}
