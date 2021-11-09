import 'package:rxdart/rxdart.dart';

class SelectProductDetailImageBLOC {
  // CONTROLLER
  final _streamCntrl = BehaviorSubject<Map<int, bool>>.seeded({
    0: true,
    1: false,
    2: false,
  });

  // STREAM
  Stream<Map<int, bool>> get stream => _streamCntrl.stream;

  // SINK
  void selectImage(int index) async {
    Map<int, bool> map = {
      0: true,
      1: false,
      2: false,
    };

    map.forEach(
      (key, value) {
        if (key == index) {
          map[key] = true;
        } else {
          map[key] = false;
        }
      },
    );

    // if (index == 0) {
    //   map = {
    //     0: true,
    //     1: false,
    //     2: false,
    //   };
    // } else if (index == 1) {
    //   map = {
    //     0: false,
    //     1: true,
    //     2: false,
    //   };
    // } else if (index == 2) {
    //   map = {
    //     0: false,
    //     1: false,
    //     2: true,
    //   };
    // }

    _streamCntrl.add(map);
  }

  get value {}

  // DISPOSE
  void dispose() {
    _streamCntrl.close();
  }
}
