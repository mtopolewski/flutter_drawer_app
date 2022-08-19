import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/events/navigation_drawer_event.dart';
import '../blocs/navigation_drawer_bloc.dart';
import '../blocs/states/navigation_drawer_states.dart';
import 'blue_page.dart';
import 'green_page.dart';
import 'red_page.dart';
import 'yellow_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer app")),
      drawer: Drawer(
        child: ListView(
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
              title: const Text('Red'),
              onTap: () {
                _navigationItemClick(NavigationType.pageRed, context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Yellow'),
              onTap: () {
                _navigationItemClick(NavigationType.pageYellow, context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Green'),
              onTap: () {
                _navigationItemClick(NavigationType.pageGreen, context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Blue'),
              onTap: () {
                _navigationItemClick(NavigationType.pageBlue, context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NavigationDrawerBloc, NavigationDrawerState>(
        builder: (context, state) {
          switch (state.navigationType) {
            case NavigationType.pageRed:
              return const RedPage();
            case NavigationType.pageYellow:
              return const YellowPage();
            case NavigationType.pageGreen:
              return const GreenPage();
            case NavigationType.pageBlue:
              return const BluePage();
            default:
              return const RedPage();
          }
        },
      ),
    );
  }

  void _navigationItemClick(
      NavigationType navigationType, BuildContext context) {
    BlocProvider.of<NavigationDrawerBloc>(context)
        .add(NavigateToEvent(navigationType));
  }
}
