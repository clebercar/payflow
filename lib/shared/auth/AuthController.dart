import 'package:flutter/material.dart';
import 'package:payflow/shared/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;

      /** pushReplacementNamed - remove action that return to previous page */
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> hasCurrentUser(
    BuildContext context,
  ) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));

    if (instance.containsKey('user')) {
      final user = instance.get('user') as String;
      setUser(context, UserModel.fromJson(user));
      return;
    }

    setUser(context, null);
  }
}
