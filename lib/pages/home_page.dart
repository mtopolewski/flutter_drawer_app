import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_localizations.dart';
import '../blocs/app_language_cubit.dart';
import '../blocs/events/navigation_drawer_event.dart';
import '../blocs/navigation_drawer_bloc.dart';
import '../blocs/states/app_language_state.dart';
import '../blocs/states/navigation_drawer_states.dart';
import '../helpers/page_name_mapper.dart';
import 'blue_page.dart';
import 'green_page.dart';
import 'red_page.dart';
import 'yellow_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..reset();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    _controller.reset();
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = Localizations.localeOf(context);
    BlocProvider.of<AppLanguageCubit>(context).getStoredLocale(locale);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NavigationDrawerBloc, NavigationDrawerState>(
          builder: (context, state) => Text(AppLocalizations.of(context)!
              .translate(PageNameMapper.map[state.navigationType]!)!),
        ),
      ),
      drawer: Drawer(
        child: _getDrawerItems(),
      ),
      body: _getBody(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigationItemClick(NavigationType navigationType, BuildContext context) {
    _controller.reset();
    _controller.forward();
    BlocProvider.of<NavigationDrawerBloc>(context).add(
      NavigateToEvent(navigationType),
    );

    context.read<NavigationDrawerBloc>().add(
          NavigateToEvent(navigationType),
        );
  }

  _localizationItemClick(String local) =>
      context.read<AppLanguageCubit>().changeLanguage(Locale(local));

  _getDrawerItems() => ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Icon(
              Icons.flutter_dash,
              size: 50,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("RedPage")!),
            onTap: () {
              _navigationItemClick(NavigationType.pageRed, context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("YellowPage")!),
            onTap: () {
              _navigationItemClick(NavigationType.pageYellow, context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("GreenPage")!),
            onTap: () {
              _navigationItemClick(NavigationType.pageGreen, context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("BluePage")!),
            onTap: () {
              _navigationItemClick(NavigationType.pageBlue, context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("Languages")!),
          ),
          BlocBuilder<AppLanguageCubit, AppLanguageState>(
              builder: (context, state) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: const Text('pl'),
                  leading: Radio<String>(
                    value: "pl",
                    groupValue: state.appLocale?.languageCode,
                    onChanged: (_) => _localizationItemClick("pl"),
                  ),
                ),
                ListTile(
                  title: const Text('en'),
                  leading: Radio<String>(
                    value: "en",
                    groupValue: state.appLocale?.languageCode,
                    onChanged: (_) => _localizationItemClick("en"),
                  ),
                ),
              ],
            );
          }),
        ],
      );

  _getBody() => BlocBuilder<NavigationDrawerBloc, NavigationDrawerState>(
        builder: (context, state) {
          switch (state.navigationType) {
            case NavigationType.pageRed:
              return FadeTransition(
                opacity: _animation,
                child: const RedPage(),
              );
            case NavigationType.pageYellow:
              return FadeTransition(
                opacity: _animation,
                child: const YellowPage(),
              );
            case NavigationType.pageGreen:
              return FadeTransition(
                opacity: _animation,
                child: const GreenPage(),
              );
            case NavigationType.pageBlue:
              return FadeTransition(
                opacity: _animation,
                child: const BluePage(),
              );
            default:
              return FadeTransition(
                opacity: _animation,
                child: const RedPage(),
              );
          }
        },
      );
}
