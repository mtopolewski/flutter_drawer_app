import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawer_app/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'blocs/app_language_cubit.dart';
import 'blocs/navigation_drawer_bloc.dart';
import 'blocs/states/app_language_state.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationDrawerBloc>(
          create: (BuildContext context) => NavigationDrawerBloc(),
        ),
        BlocProvider<AppLanguageCubit>(
          create: (BuildContext context) =>
              AppLanguageCubit(const Locale("en")),
        ),
      ],
      child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
          builder: (context, state) {
        return MaterialApp(
          locale: state.appLocale,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('pl', null),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const HomePage(),
        );
      }),
    );
  }
}
