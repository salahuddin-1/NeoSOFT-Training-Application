import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAddressBLOC extends Bloc<int, Map<int, bool>> {
  SelectAddressBLOC()
      : super(
          {
            0: true,
            1: false,
            2: false,
          },
        );

  @override
  Stream<Map<int, bool>> mapEventToState(int event) async* {
    Map<int, bool> map = {
      0: true,
      1: false,
      2: false,
    };
    if (event == 0) {
      map[0] = true;
      map[1] = false;
      map[2] = false;
    } else if (event == 1) {
      map[0] = false;
      map[1] = true;
      map[2] = false;
    } else if (event == 2) {
      map[0] = false;
      map[1] = false;
      map[2] = true;
    }

    yield map;
  }
}
