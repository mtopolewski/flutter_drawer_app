import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'states/app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(const AppLanguageState(null));
  static const String _key = "_key";
  Locale? _appLocale;

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale!.languageCode == type.languageCode) {
      return;
    }
    await prefs.setString(_key, type.languageCode);
    emit(state.copyWith(appLocale: type));
  }

  getStoredLocale(Locale initLocale) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_key) == null) {
      _appLocale = initLocale;
      emit(state.copyWith(appLocale: _appLocale));
      return;
    }
    _appLocale = Locale(prefs.getString(_key)!);
    emit(state.copyWith(appLocale: _appLocale));
  }
}
