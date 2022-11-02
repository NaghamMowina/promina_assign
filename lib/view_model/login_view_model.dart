import 'dart:async';

import 'package:flutter/material.dart';
import 'package:promina_assign/data/response/api_response.dart';
import 'package:promina_assign/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositry/login_repositry.dart';

class LoginViewModel with ChangeNotifier {
  //  Sink get inputMailText;
  // Stream<bool> get outputIsButtonEnabled;
  // Stream<String> get outputErrorText;
  final _loginRepo = LoginRepositry();

  // final _mailTextController = StreamController<String>.broadcast();
  // final _passwordTextController = StreamController<String>.broadcast();

  isFieldValid(String txt) {
    if (txt.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // Sink get inputMailText => _mailTextController;
  // Sink get inputPassText => _passwordTextController;

  // Stream<bool> get outputIsButtonEnabled {
  //   return _mailTextController.stream.map((email) {
  //     return isFieldValid(email);
  //   });
  // }

  // Stream<String?> get outputErrorText => outputIsButtonEnabled
  //     .map((isEnabled) => isEnabled ? null : "Invalid email");

  // void dispose() => _mailTextController.close();

  Future<bool> loginApi(email, password) async {
    if (isFieldValid(email) && isFieldValid(password)) {
      await _loginRepo.login(email, password).then((value) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', 'Bearer ${value.token}');

        // setLogin(ApiResponse.completed(value));
      });
      return true;
    } else {
      return false;
    }
  }
}
