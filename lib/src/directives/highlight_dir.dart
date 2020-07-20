import 'dart:html' as html;
import 'package:angular/angular.dart';

@Directive(selector: '[myHighlight]')
class HightLightDirective {
  html.Element _elementRef;

  @Input('myHighlight')
  String highlightColor;

  @Input('defaultColor')
  String defaultColor;

  @Input('opacity')
  String opacity;

  HightLightDirective(this._elementRef);

  @HostListener('mouseenter')
  void onMouseEnter() => _highlight(
        highlightColor ?? defaultColor ?? 'red',
        opacity,
      );

  @HostListener('mouseleave')
  void onMouseLeave() => _highlight();

  void _highlight([String color, String opacity]) {
    this._elementRef.style.transition = 'all 750ms ease';
    this._elementRef.style.opacity = opacity;
    this._elementRef.style.backgroundColor = color;
  }
}
