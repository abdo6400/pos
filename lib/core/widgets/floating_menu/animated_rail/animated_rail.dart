import 'package:flutter/material.dart';
import 'rail_item.dart';
import 'animated_rail_raw.dart';

class AnimatedRail extends StatelessWidget {
  final double width;
  final double maxWidth;
  final TextDirection? direction;
  final List<RailItem> items;
  final int? selectedIndex;
  final Color? background;
  final bool expand;
  final bool isStatic;
  final ItemBuilder? builder;
  final Size? cursorSize;
  final RailTileConfig? railTileConfig;
  final CursorActionTrigger cursorActionType;
  final ValueChanged<int>? onChange;

  const AnimatedRail({
    Key? key,
    this.width = 100,
    this.maxWidth = 350,
    this.direction,
    this.items = const [],
    this.selectedIndex,
    this.background,
    this.onChange,
    this.expand = true,
    this.isStatic = false,
    this.builder,
    this.cursorSize,
    this.railTileConfig,
    this.cursorActionType = CursorActionTrigger.drag,
  })  : assert(!expand || maxWidth > width),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedRailRaw(
      items: items,
      width: width,
      onChange: onChange,
      background: background,
      direction: direction,
      maxWidth: maxWidth,
      selectedIndex: selectedIndex,
      expand: expand,
      isStatic: isStatic,
      railTileConfig: railTileConfig,
      builder: builder,
      cursorSize: cursorSize,
      cursorActionType: cursorActionType,
    );
  }
}
