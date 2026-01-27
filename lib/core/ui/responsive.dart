import 'package:flutter/widgets.dart';

class Breakpoints {
  static const double tablet = 700;
  static const double desktop = 1024;
}

extension ResponsiveX on BuildContext {
  bool get isTablet => MediaQuery.sizeOf(this).width >= Breakpoints.tablet;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= Breakpoints.desktop;
}
