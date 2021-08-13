import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crud_flutter/model/movies.dart';

part 'moviesBase.g.dart';

class MoviesBase = MoviesListBase with _$MoviesBase;
abstract class MoviesListBase with Store{

  @observable
  ObservableList<Movies> moviesList = ObservableList<Movies>();

  @observable
  int counterIndex = 0;

  @action
  deleteList() async {
    moviesList.clear();
  }

  @computed
  ObservableList<Movies> get lists => moviesList;

  @computed
  int get listLength => moviesList.length;

  @action
  createMoviesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    print("data $keys");
    keys.forEach((element) {
      print("keys : $element");
      if (element != "primarykey") {
        String values = prefs.getString(element) ?? "";
        if (values.isNotEmpty) {
          List<String> movies = values.split("||");
          int primarykeys = int.parse(element);
          String title = movies[0];
          String director = movies[1];
          String summary = movies[2];
          String tags = movies[3];
          print("$primarykeys $title $director $summary $tags");
          Movies film = Movies(primarykeys, title, director, summary, tags);
          print("data $primarykeys $title $director $summary $tags");
          moviesList.add(film);
          print("movies list size ${moviesList.length}");
        }
      }
    });
  }

  @action
  inputMovies(String pk, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String values = prefs.getString(pk) ?? "";
    print("values of key data $values $pk $data");
    prefs.setString(pk, data).then((bool success) {
      if (success) {
        print("data successfully added / updated");
        print("${prefs.getString(pk)}");
      }
      return success;
    });
    List<String> movies = data.split("||");
    int primarykeys = int.parse(pk);
    String title = movies[0];
    String director = movies[1];
    String summary = movies[2];
    String tags = movies[3];
    print("$primarykeys $title $director $summary $tags");
    Movies film = Movies(primarykeys, title, director, summary, tags);
    print("data $primarykeys $title $director $summary $tags");
    moviesList.add(film);
    print("movies list size ${moviesList.length}");
  }



  @action
  deleteMovies(String pk,data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(pk);
    List<String> movies = data.split("||");
    int primarykeys = int.parse(pk);
    String title = movies[0];
    String director = movies[1];
    String summary = movies[2];
    String tags = movies[3];
    print("$primarykeys $title $director $summary $tags");
    Movies film = Movies(primarykeys, title, director, summary, tags);
    print("data $primarykeys $title $director $summary $tags");
    moviesList.remove(film);
  }

  @action
  createIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt("primarykey") ?? 0;
    print("$counter");
    counter++;
    print("$counter increase");
    prefs.setInt("primarykey", counter).then((bool success) {
      if (success) print("primary key updated : $counter");
      counterIndex = counter;
    });
    // if (counter != 0) {
    //   counter++;
    //   print("$counter increase");
    //   prefs.setInt("primarykey", counter).then((bool success) {
    //     if (success) print("primary key updated : $counter");
    //     counterIndex = counter;
    //   });
    // } else {
    //   prefs.setInt("primarykey", counter).then((bool success) {
    //     if (success) print("primary key updated : $counter");
    //     counterIndex = counter;
    //   });
    // }

  }

  @computed
  int get currentIndex => counterIndex;

}
