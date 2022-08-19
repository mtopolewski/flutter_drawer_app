import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/events/navigation_drawer_event.dart';
import '../blocs/navigation_drawer_bloc.dart';
import '../blocs/states/navigation_drawer_states.dart';
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigationItemClick(
      NavigationType navigationType, BuildContext context) {
    _controller.reset();
    _controller.forward();
    BlocProvider.of<NavigationDrawerBloc>(context).add(
      NavigateToEvent(navigationType),
    );
  }
}
