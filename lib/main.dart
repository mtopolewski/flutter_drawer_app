import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawer_app/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'blocs/navigation_drawer_bloc.dart';

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
      ],
      child: const MaterialApp(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pl', null),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        home: HomePage(),
      ),
    );
  }
}
