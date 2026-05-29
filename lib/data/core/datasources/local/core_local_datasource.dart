import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

abstract class CoreLocalDataSource {
  Future<void> setSessionStatus(bool status);
  Future<bool> getSessionStatus();
}

const String _sessionStatusKey = 'session_status_key';

@LazySingleton(as: CoreLocalDataSource)
class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  final SharedPreferences _sharedPreferences;

  CoreLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> getSessionStatus() async {
    return _sharedPreferences.getBool(_sessionStatusKey) ?? false; // Default to false if not set
  }

  @override
  Future<void> setSessionStatus(bool status) async {
    await _sharedPreferences.setBool(_sessionStatusKey, status);
  }
}
