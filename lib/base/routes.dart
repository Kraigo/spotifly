import 'package:flutter/material.dart';
import 'package:spotifly/screens/home_screen.dart';
import 'package:spotifly/screens/library_screen.dart';
import 'package:spotifly/screens/login_screen.dart';
import 'package:spotifly/screens/playlist_screen.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const playlist = '/playlist';
  static const library = '/library';

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? pageArguments;

    if (settings.arguments != null) {
      pageArguments = settings.arguments as Map<String, dynamic>;
    }

    var routes = <String, WidgetBuilder>{
      Routes.login: (context) => const LoginScreen(),
      Routes.home: (context) => const HomeScreen(),
      Routes.library: (context) => const LibraryScreen(),
      Routes.playlist: (context) =>
          PlaylistScreen(playlist: pageArguments?['playlist']),
    };
    WidgetBuilder builder = routes[settings.name] ?? routes.values.first;
    return MaterialPageRoute(builder: (ctx) => builder(ctx), settings: settings);
  }
}
