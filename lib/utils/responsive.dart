import 'package:flutter/material.dart';
/// For your information chat GPT made this class for me
/// Responsive widget that adjusts its content based on screen size.
///
/// Usage:
/// ```dart
/// Responsive(
///   mobile: MobileWidget(),
///   tablet: TabletWidget(),
///   desktop: DesktopWidget(),
///   mobileLarge: MobileLargeWidget(),
/// )
/// ```
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.mobileLarge,
  }) : super(key: key);

  /// Check if the screen width is less than or equal to 500.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 500;

  /// Check if the screen width is less than or equal to 700.
  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700;

  /// Check if the screen width is less than 1024.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024;

  /// Check if the screen width is greater than or equal to 1024.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1024) {
      return desktop;
    } else if (_size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (_size.width >= 500 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
