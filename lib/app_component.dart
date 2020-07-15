import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:viewer/src/search/search_component.dart';
import 'package:viewer/src/utils/routes.dart';

@Component(
  selector: 'my-app',
  templateUrl: "./app_template.html",
  directives: [
    routerDirectives,
    SearchComponent,
  ],
  providers: [],
  exports: [RoutePaths, Routes],
)
class AppComponent {}
