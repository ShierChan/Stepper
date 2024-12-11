import 'dart:ui';

import 'package:flutter/material.dart';

/// 给一个元素模糊效果
///
/// 并在光标移动在此元素之上时去除模糊效果
class FlexibleBlurContainer extends StatefulWidget {
  const FlexibleBlurContainer(
      {super.key, required this.child, required this.alwaysVisible});

  final bool alwaysVisible;
  final Widget child;

  @override
  State<FlexibleBlurContainer> createState() => FlexibleBlurContainerState();
}

class FlexibleBlurContainerState extends State<FlexibleBlurContainer> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
            sigmaX: isHover || widget.alwaysVisible ? 0 : 20,
            sigmaY: isHover || widget.alwaysVisible ? 0 : 20),
        child: widget.child,
      ),
    );
  }
}
