import 'dart:async';
import 'dart:convert';


import 'package:inspector/data/auth/models/user/user_model.dart';
import 'package:inspector/data/core/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> signInUser(UserModel user);

  UserModel? getSignedInUser();

  void logout();

  StreamController<UserModel?> get authStatus;

  void dispose();
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;
  final StreamController<UserModel?> _authStatusStream =
      StreamController<UserModel?>.broadcast();

  AuthLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> signInUser(UserModel user) async {
    await sharedPreferences.setString(
      SharedPreferencesKeys.user,
      json.encode(user.toJson()),
    );
  }

  @override
  UserModel? getSignedInUser() {
    if (!sharedPreferences.containsKey(SharedPreferencesKeys.user)) return null;
    var userMap =json.decode(sharedPreferences.getString(SharedPreferencesKeys.user)!);
    return UserModel.fromJson(userMap);

  }

  @override
  void logout() {
     sharedPreferences.remove(SharedPreferencesKeys.user);
  }

  @override
  StreamController<UserModel?> get authStatus => _authStatusStream;

  @override
  @disposeMethod
  void dispose() {
    _authStatusStream.close();
  }
}
