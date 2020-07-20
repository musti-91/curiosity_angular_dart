import 'dart:html' as html;
import 'package:angular/angular.dart';

int _idCounter = 0;

@Directive(selector: "[autoId]")
void autoIdDirective(
  html.Element element,
  @Attribute('autoId') String prefix,
) {
  element.id = '$prefix-${_idCounter++}';
}
