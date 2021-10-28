import 'package:shared_preferences/shared_preferences.dart';

class SaveAddressToLocalStorage {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveAddress(String address) async {
    final prefs = await _prefs;

    bool hasAddress = prefs.containsKey('addressList');

    if (!hasAddress) {
      await prefs.setStringList(
        'addressList',
        [],
      );
    }
    final addressList = prefs.getStringList('addressList')!;

    if (addressList.length == 3) {
      addressList.removeAt(0);
    }

    addressList.add(address);

    await prefs.setStringList(
      'addressList',
      addressList,
    );

    print(prefs.getStringList('addressList')!);
  }

  Future<List<String>> getAddress() async {
    final prefs = await _prefs;

    if (prefs.containsKey('addressList')) {
      return prefs.getStringList('addressList')!;
    }

    return [];
  }
}
