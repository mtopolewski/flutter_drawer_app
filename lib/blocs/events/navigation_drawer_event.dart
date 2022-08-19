enum NavigationType {
  pageRed,
  pageYellow,
  pageGreen,
  pageBlue,
}

abstract class NavigationDrawerEvent {}

class NavigateToEvent extends NavigationDrawerEvent {
  NavigateToEvent(this.navigationType);
  final NavigationType navigationType;
}
