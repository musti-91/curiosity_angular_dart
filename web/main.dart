import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart';

import 'package:viewer/src/utils/in_memory_data_service.dart';

import 'package:viewer/app_component.template.dart' as App;
import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash,
  // for real server
  // ClassProvider(Client, useClass: BrowserClient),
  ClassProvider(Client, useClass: InMemoryDataService),
])
final InjectorFactory injector = self.injector$Injector;
void main() {
  runApp(
    App.AppComponentNgFactory,
    createInjector: injector,
  );
}
