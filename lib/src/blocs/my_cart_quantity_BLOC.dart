import 'package:rxdart/rxdart.dart';

class MyCartQtyBLOC {
  final _streamCntrl = new BehaviorSubject<int>();

  setValue(int val) {
    _streamCntrl.sink.add(val);
  }

  Stream<int> get stream => _streamCntrl.stream;

  void dispose() {
    _streamCntrl.close();
  }
}
