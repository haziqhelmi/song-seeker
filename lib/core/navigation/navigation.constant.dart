import 'package:flutter/material.dart';
import 'package:song_seeker/ui/home/home.view.dart';
import 'package:song_seeker/ui/ranking/ranking.view.dart';
import 'package:song_seeker/ui/search/search.view.dart';

class NavConstant {
  NavConstant();

  static const String homeRoute = '/home';
  static const String rankingRoute = '/ranking';
  static const String searchRoute = '/search';

  static MaterialPageRoute _pageRoute(
    Widget page, {
    bool isFullscreenDialog = false,
  }) {
    return MaterialPageRoute(
        builder: (_) => page, fullscreenDialog: isFullscreenDialog);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _pageRoute(HomeView());
      case rankingRoute:
        return _pageRoute(RankingView());
      case searchRoute:
        return _pageRoute(SearchView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
            child: Text('No route found: ${settings.name}'),
          )),
        );
    }
  }
}
