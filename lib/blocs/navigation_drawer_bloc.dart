import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/navigation_drawer_event.dart';
import 'states/navigation_drawer_states.dart';

class NavigationDrawerBloc
    extends Bloc<NavigationDrawerEvent, NavigationDrawerState> {
  NavigationDrawerBloc()
      : super(const NavigationDrawerState(NavigationType.pageRed)) {
    on<NavigateToEvent>(
        (event, emit) => emit(NavigationDrawerState(event.navigationType)));
  }
}
