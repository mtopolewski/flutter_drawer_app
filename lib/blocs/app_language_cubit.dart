import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit(Locale? initLocale) : super(AppLanguageState(initLocale));
  //: super(const AppLanguageState(Locale('en')));
  Locale? _appLocale;

  void changeLanguage(Locale type) async {
    // if (_appLocale!.languageCode == type.languageCode) {
    //   return;
    // }

    emit(state.copyWith(appLocale: type));
  }
}
