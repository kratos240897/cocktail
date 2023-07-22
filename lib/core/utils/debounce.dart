import 'dart:async';

class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce(
    this.delay,
  );

  call(void Function() callback) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}