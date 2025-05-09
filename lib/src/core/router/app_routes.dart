class AppRoutes {
  ///
  /// isMaintenanceBreak is a global variable that is set to true when the app
  static const isMaintenanceBreak = false;

  ///
  static const String homeRoute = '/';
  static const String settingsRoute = '/settings';
  static const String maintenanceBreakRoute = '/maintenance-break';

  static const List<String> allRoutes = [
    homeRoute,
    settingsRoute,
  ];

}
