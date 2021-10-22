import 'package:rxdart/rxdart.dart';

class SetRatingsStarBLOC {
  final _streamCNtrl = BehaviorSubject<int>.seeded(5);

  Stream<int> get stream => _streamCNtrl.stream;

  void setRatings(int rating) {
    _streamCNtrl.add(rating);
  }

  void dispose() {
    _streamCNtrl.close();
  }
}
