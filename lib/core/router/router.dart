import 'package:flutter/material.dart';
import 'package:fluttercleancode/features/watchlist/presentation/pages/watchlist.dart';

import '../../features/login/presentation/pages/login_page.dart';
import '../../main.dart';

class AppRouter {
  static const routeSplash = "/splash";
  static const routelogin = "/login";
  static const routeWatchlist = "/watchlist";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case routeSplash:
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      case routelogin:
        return MaterialPageRoute(
            builder: (_) => LoginPage(loginBloc: sl.get()));
      case routeWatchlist:
        return MaterialPageRoute(
            builder: (_) => Watchlist(watchlistBloc: sl.get()));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text("No route"))));
    }
  }
}
