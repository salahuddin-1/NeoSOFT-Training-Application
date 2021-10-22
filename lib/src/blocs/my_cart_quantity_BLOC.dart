import 'package:rxdart/rxdart.dart';

class MyCartQtyBLOC {
  final _streamCntrl = new BehaviorSubject<int>.seeded(1);

  setValue(int val) {
    _streamCntrl.sink.add(val);
  }

  int get value => _streamCntrl.value;

  Stream<int> get stream => _streamCntrl.stream;

  void dispose() {
    _streamCntrl.close();
  }
}
