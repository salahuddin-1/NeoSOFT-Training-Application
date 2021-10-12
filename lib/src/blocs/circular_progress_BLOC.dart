import 'package:rxdart/rxdart.dart';

class CircularProgressBLOC {
  final _streamCntrl = BehaviorSubject<bool>.seeded(false);

  Sink<bool> get sink => _streamCntrl.sink;

  Stream<bool> get stream => _streamCntrl.stream;

  bool get value => _streamCntrl.value;

  void dispose() {
    _streamCntrl.close();
  }
}
