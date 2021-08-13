import 'package:auto_route/annotations.dart';
import 'package:crud_flutter/screen/editPage.dart';
import 'package:crud_flutter/screen/mainPage.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: MoviesLists, initial: true,),
  AutoRoute(page: EditMovies),
])
class $AppRouter {}
