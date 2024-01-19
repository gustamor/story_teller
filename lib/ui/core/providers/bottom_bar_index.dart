
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = NotifierProvider<IndexNotifier, int>(
  IndexNotifier.new,
);

class IndexNotifier extends Notifier<int> {
  IndexNotifier() : super();

  set value(int index) => state = index;

  @override
  int build() {
    return 1; // default index
  }
}
