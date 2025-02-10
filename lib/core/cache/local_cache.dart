import 'package:get_storage/get_storage.dart';

class LocalCache {
  final GetStorage _storage = GetStorage();

  void saveData({required String key, required dynamic value}) {
    _storage.write(key, value);
  }

  String? getDataString({required String key}) {
    return _storage.read<String>(key);
  }

  dynamic getData({required String key}) {
    return _storage.read(key);
  }

  bool containsKey({required String key}) {
    return _storage.hasData(key);
  }

  void removeData({required String key}) {
    _storage.remove(key);
  }

  void clearData() {
    _storage.erase();
  }
}
