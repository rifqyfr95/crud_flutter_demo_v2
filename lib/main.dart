import 'package:flutter/material.dart';
import 'router.gr.dart';
void main() {
  runApp(MovieCRUD());
}

class MovieCRUD extends StatelessWidget {

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.light(),
      routerDelegate: _appRouter.delegate(
        initialRoutes: [MoviesListsRoute(title:'Movies'),],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

