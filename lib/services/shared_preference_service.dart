import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferenceService {
  const SharedPreferenceService();

  Future<void> saveInt({
    required String key,
    required int value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<void> saveDouble({
    required String key,
    required double value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getDouble(key);
  }

  Future<void> saveBool({
    required String key,
    required bool value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  Future<void> saveString({
    required String key,
    required String value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> saveList({
    required String key,
    required List<String> valueIter,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList(key, valueIter);
  }

  Future<List<String>?> getStringList(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }

  Future<void> remove(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  Future<void> clear() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
