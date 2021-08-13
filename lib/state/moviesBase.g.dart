// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviesBase.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MoviesBase on MoviesListBase, Store {
  Computed<ObservableList<Movies>>? _$listsComputed;

  @override
  ObservableList<Movies> get lists =>
      (_$listsComputed ??= Computed<ObservableList<Movies>>(() => super.lists,
              name: 'MoviesListBase.lists'))
          .value;
  Computed<int>? _$listLengthComputed;

  @override
  int get listLength =>
      (_$listLengthComputed ??= Computed<int>(() => super.listLength,
              name: 'MoviesListBase.listLength'))
          .value;

  final _$moviesListAtom = Atom(name: 'MoviesListBase.moviesList');

  @override
  ObservableList<Movies> get moviesList {
    _$moviesListAtom.reportRead();
    return super.moviesList;
  }

  @override
  set moviesList(ObservableList<Movies> value) {
    _$moviesListAtom.reportWrite(value, super.moviesList, () {
      super.moviesList = value;
    });
  }

  final _$counterIndexAtom = Atom(name: 'MoviesListBase.counterIndex');

  @override
  int get counterIndex {
    _$counterIndexAtom.reportRead();
    return super.counterIndex;
  }

  @override
  set counterIndex(int value) {
    _$counterIndexAtom.reportWrite(value, super.counterIndex, () {
      super.counterIndex = value;
    });
  }

  final _$deleteListAsyncAction = AsyncAction('MoviesListBase.deleteList');

  @override
  Future deleteList() {
    return _$deleteListAsyncAction.run(() => super.deleteList());
  }

  final _$createMoviesListAsyncAction =
      AsyncAction('MoviesListBase.createMoviesList');

  @override
  Future createMoviesList() {
    return _$createMoviesListAsyncAction.run(() => super.createMoviesList());
  }

  final _$inputMoviesAsyncAction = AsyncAction('MoviesListBase.inputMovies');

  @override
  Future inputMovies(String pk, String data) {
    return _$inputMoviesAsyncAction.run(() => super.inputMovies(pk, data));
  }

  final _$deleteMoviesAsyncAction = AsyncAction('MoviesListBase.deleteMovies');

  @override
  Future deleteMovies(String pk, dynamic data) {
    return _$deleteMoviesAsyncAction.run(() => super.deleteMovies(pk, data));
  }

  @override
  String toString() {
    return '''
moviesList: ${moviesList},
counterIndex: ${counterIndex},
lists: ${lists},
listLength: ${listLength}
    ''';
  }
}
