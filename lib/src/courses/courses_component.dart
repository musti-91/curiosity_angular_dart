import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'courses',
  // templateUrl: './courses_template.html',
  template: '''<h1>courses list</h1>''',
  directives: [coreDirectives],
  providers: [],
)
class CoursesList implements OnInit {
  @override
  Future<Null> ngOnInit() async {
    // wait for something to finish
  }
}
