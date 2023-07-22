import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedVisibility extends HookWidget {
  final bool visible;
  final Widget child;
  final Duration duration;

  const AnimatedVisibility({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(visible);

    useEffect(() {
      if (visible != isVisible.value) {
        isVisible.value = visible;
      }
      return null;
    }, [visible]);

    return AnimatedOpacity(
      opacity: isVisible.value ? 1.0 : 0.0,
      duration: duration,
      curve: Curves.easeInOutBack,
      child: isVisible.value ? child : Container(),
    );
  }
}
