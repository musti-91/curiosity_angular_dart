import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:viewer/src/utils/routes.dart';

@Component(
  selector: 'my-app',
  template: '''
    <h1>{{title}}</h1>
    <nav>
        <a [routerLink]="RoutePaths.courses.toUrl()">Courses</a>
    </nav>
    <router-outlet [routes]="Routes.all"></router-outlet>
  ''',
  directives: [routerDirectives],
  providers: [],
  exports: [RoutePaths, Routes],
)
class AppComponent {
  final String title = 'Courses';
}
