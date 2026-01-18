import 'dart:async';
import 'dart:ui';

class DebounceClass {
  final int milliseconds;
  Timer? _timer;
  DebounceClass({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}