import 'package:flutter/material.dart';

class RailItem {
  final Widget icon;
  final String? label;
  final Color? background;
  final Color? activeColor;
  final Color? iconColor;

  RailItem({
    required this.icon,
    this.label,
    this.background,
    this.activeColor,
    this.iconColor,
  });
}

class RailTileConfig {
  final EdgeInsetsGeometry? iconPadding;
  final TextStyle? expandedTextStyle;
  final TextStyle? collapsedTextStyle;
  final double? iconSize;
  final Color? iconBackground;
  final Color? activeColor;
  final Color? iconColor;
  final bool? hideCollapsedText;

  const RailTileConfig({
    this.iconPadding,
    this.expandedTextStyle,
    this.collapsedTextStyle,
    this.iconSize,
    this.iconBackground,
    this.activeColor,
    this.iconColor,
    this.hideCollapsedText,
  });
}

enum CursorActionTrigger {
  clickAndDrag,
  drag,
}
