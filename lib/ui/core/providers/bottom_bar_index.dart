import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateProvider<int>((ref) {
  return 1; // default index
});

class IndexNotifier {
 final StateController<int> _controller;

  IndexNotifier(this._controller);

  set value(int index) {
    if (_controller.state != index) {
      _controller.state = index;
    }
  }

  int get value => _controller.state;
}