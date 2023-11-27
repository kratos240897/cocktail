import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedVisibility extends HookWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;

  const AnimatedVisibility({
    super.key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: duration,
      curve: Curves.easeInOutBack,
      child: isVisible ? child : Container(),
    );
  }
}
