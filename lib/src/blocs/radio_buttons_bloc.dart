import 'package:rxdart/rxdart.dart';

class RadioButtonsBloc {
  final _genderBloc = BehaviorSubject<Map<String, bool>>.seeded({
    'male': true,
    'female': false,
  });

  Stream<Map<String, bool>> get genderStream => _genderBloc.stream;

  String get value {
    if (_genderBloc.value['female'] == true) {
      return 'Female';
    }

    return 'Male';
  }

  selectGender(String key) {
    Map<String, bool> map;

    if (key == 'female') {
      map = {
        'male': false,
        'female': true,
      };
    } else {
      map = {
        'male': true,
        'female': false,
      };
    }
    _genderBloc.sink.add(map);
  }

  final _termsAndConditionsCntrl = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get termsAndConditionsStream => _termsAndConditionsCntrl.stream;

  selectTermsAndConditions() {
    if (_termsAndConditionsCntrl.value) {
      _termsAndConditionsCntrl.sink.add(false);
      return;
    }
    _termsAndConditionsCntrl.sink.add(true);
  }

  bool get iAgree => _termsAndConditionsCntrl.value;

  dispose() {
    _genderBloc.close();
    _termsAndConditionsCntrl.close();
  }
}
