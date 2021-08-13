// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:crud_flutter/model/movies.dart' as _i5;
import 'package:crud_flutter/screen/editPage.dart' as _i4;
import 'package:crud_flutter/screen/mainPage.dart' as _i3;
import 'package:flutter/material.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MoviesListsRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MoviesListsRouteArgs>();
          return _i3.MoviesLists(key: args.key, title: args.title);
        }),
    EditMoviesRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EditMoviesRouteArgs>();
          return _i4.EditMovies(
              key: args.key,
              title: args.title,
              type: args.type,
              movies: args.movies);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MoviesListsRoute.name, path: '/'),
        _i1.RouteConfig(EditMoviesRoute.name, path: '/edit-movies')
      ];
}

class MoviesListsRoute extends _i1.PageRouteInfo<MoviesListsRouteArgs> {
  MoviesListsRoute({_i2.Key? key, required String title})
      : super(name,
            path: '/', args: MoviesListsRouteArgs(key: key, title: title));

  static const String name = 'MoviesListsRoute';
}

class MoviesListsRouteArgs {
  const MoviesListsRouteArgs({this.key, required this.title});

  final _i2.Key? key;

  final String title;
}

class EditMoviesRoute extends _i1.PageRouteInfo<EditMoviesRouteArgs> {
  EditMoviesRoute(
      {_i2.Key? key,
      required String title,
      required int type,
      _i5.Movies? movies})
      : super(name,
            path: '/edit-movies',
            args: EditMoviesRouteArgs(
                key: key, title: title, type: type, movies: movies));

  static const String name = 'EditMoviesRoute';
}

class EditMoviesRouteArgs {
  const EditMoviesRouteArgs(
      {this.key, required this.title, required this.type, this.movies});

  final _i2.Key? key;

  final String title;

  final int type;

  final _i5.Movies? movies;
}
