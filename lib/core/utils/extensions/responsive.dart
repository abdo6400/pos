import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension Responsive on BuildContext {
  bool get isDesktop => ResponsiveBreakpoints.of(this).isDesktop;
  bool get isTablet => ResponsiveBreakpoints.of(this).isTablet;
  bool get isMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isPhone => ResponsiveBreakpoints.of(this).isPhone;

  bool DeviceTypeEqual(String name) {
    return ResponsiveBreakpoints.of(this).equals(name);
  }

  bool DeviceTypeLargerThan(String name) {
    return ResponsiveBreakpoints.of(this).largerThan(name);
  }

  bool DeviceTypeSmallerThan(String name) {
    return ResponsiveBreakpoints.of(this).smallerThan(name);
  }

  bool DeviceTypeBetween(String name1, String name2) {
    return ResponsiveBreakpoints.of(this).between(name1, name2);
  }

  double ResponsiveValu(double defaultValue,
          {double? mobile, double? tablet, double? desktop}) =>
      ResponsiveValue(
        this,
        defaultValue: defaultValue,
        conditionalValues: [
          Condition.smallerThan(name: MOBILE, value: mobile),
          Condition.equals(name: TABLET, value: tablet),
          Condition.equals(name: DESKTOP, value: desktop),
        ],
      ).value;
}

