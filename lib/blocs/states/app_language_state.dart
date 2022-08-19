import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppLanguageState extends Equatable {
  const AppLanguageState(this.appLocale);
  final Locale? appLocale;

  AppLanguageState copyWith({Locale? appLocale}) =>
      AppLanguageState(appLocale ?? this.appLocale);

  @override
  List<Object?> get props => [appLocale];
}
