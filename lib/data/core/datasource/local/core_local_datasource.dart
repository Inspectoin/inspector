import 'package:inspector/data/core/utils/constants.dart'; // Added for SharedPreferencesKeys
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoreLocalDataSource {
  // Methods from original file
  bool isFirstTime();
  void setFirstTime(bool value);

  // New methods for session status
  Future<void> setSessionStatus(bool status);
  Future<bool> getSessionStatus();
}


@LazySingleton(as: CoreLocalDataSource)
class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  final SharedPreferences sharedPreferences;

  CoreLocalDataSourceImpl(this.sharedPreferences);

  @override
  bool isFirstTime() {
    if (!sharedPreferences.containsKey(SharedPreferencesKeys.firstTime)) return true;
    return sharedPreferences.getBool(SharedPreferencesKeys.firstTime)!;
  }

  @override
  void setFirstTime(bool value) {
    sharedPreferences.setBool(SharedPreferencesKeys.firstTime, value);
  }

  // Implementation for new methods
  @override
  Future<bool> getSessionStatus() async {
    return sharedPreferences.getBool(SharedPreferencesKeys.sessionStatusKey) ?? true;
  }

  @override
  Future<void> setSessionStatus(bool status) async {
    await sharedPreferences.setBool(SharedPreferencesKeys.sessionStatusKey, status);
  }
}
