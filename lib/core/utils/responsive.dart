import 'package:flutter/widgets.dart';

enum AppBreakpoint { mobile, tablet, desktop }

class Responsive {
  const Responsive._();

  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  static AppBreakpoint breakpointFor(double width) {
    if (width < mobileMax) {
      return AppBreakpoint.mobile;
    }
    if (width <= tabletMax) {
      return AppBreakpoint.tablet;
    }
    return AppBreakpoint.desktop;
  }

  static AppBreakpoint of(BuildContext context) {
    return breakpointFor(MediaQuery.sizeOf(context).width);
  }

  static bool isMobile(BuildContext context) =>
      of(context) == AppBreakpoint.mobile;

  static bool isTablet(BuildContext context) =>
      of(context) == AppBreakpoint.tablet;

  static bool isDesktop(BuildContext context) =>
      of(context) == AppBreakpoint.desktop;
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Responsive.breakpointFor(constraints.maxWidth);
        return switch (breakpoint) {
          AppBreakpoint.mobile => mobile,
          AppBreakpoint.tablet => tablet ?? mobile,
          AppBreakpoint.desktop => desktop ?? tablet ?? mobile,
        };
      },
    );
  }
}
