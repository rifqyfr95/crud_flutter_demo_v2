import 'package:auto_route/auto_route.dart';
import 'package:crud_flutter/model/movies.dart';
import 'package:crud_flutter/state/moviesBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router.gr.dart';
import 'dart:async';

class MoviesLists extends StatefulWidget {
  MoviesLists({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MoviesListsState createState() => _MoviesListsState();
}

class _MoviesListsState extends State<MoviesLists> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _moviesBase = MoviesBase();
  // List<Movies> moviesList = <Movies>[];

  // Future<void> loadData() async {
  //   final SharedPreferences prefs = await _prefs;
  //   final keys = prefs.getKeys();
  //   print("data $keys");
  //   keys.forEach((element) {
  //     print("keys : $element");
  //     if (element != "primarykey") {
  //       String values = prefs.getString(element) ?? "";
  //       if (values.isNotEmpty) {
  //         List<String> movies = values.split("||");
  //         int primarykeys = int.parse(movies[0]);
  //         String title = movies[1];
  //         String director = movies[2];
  //         String summary = movies[3];
  //         String tags = movies[4];
  //         print("$primarykeys $title $director $summary $tags");
  //         Movies film = Movies(primarykeys, title, director, summary, tags);
  //         moviesList.add(film);
  //       }
  //     }
  //   });
  // }

  Widget buildList() {
    // Future.delayed(Duration(seconds: 3),(){
    //   if(mounted){
    //     setState(() {
    //     });
    //   }
    // });

    Timer timers = new Timer(Duration(seconds: 3), (){
      if(_moviesBase.listLength > 0){
        if(mounted){
          setState(() {

          });
        }
      }
    });
    print("masuk sini ${_moviesBase.listLength}");
    if (_moviesBase.listLength != 0) {
      timers.cancel();
      print("masuk sini ke 0 ${_moviesBase.listLength}");
      return Observer(builder: (_)=>
          ListView.builder(
              itemCount: _moviesBase.lists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_moviesBase.lists[index].title),
                  subtitle: Text(_moviesBase.lists[index].director),
                  onTap: () {
                    print("clicked ${_moviesBase.lists[index].pk} ${_moviesBase.lists[index].title} ${_moviesBase.lists[index].director} ${_moviesBase.lists[index].summary} ${_moviesBase.lists[index].tags}");
                    Movies movies = Movies(_moviesBase.lists[index].pk,
                      _moviesBase.lists[index].title,
                      _moviesBase.lists[index].director,
                      _moviesBase.lists[index].summary,
                      _moviesBase.lists[index].tags,
                    );
                    AutoRouter.of(context).replace(EditMoviesRoute(title: "Edit Movies", type: 1, movies: movies));
                  },
                );
              })
      );
    } else {
      print("masuk sini ke 1 ${_moviesBase.listLength}");
      return Center(
        child: Text("No entry yet"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                AutoRouter.of(context).replace(EditMoviesRoute(title: "New Movies", type: 0, movies: Movies(0,"","","","")));
              },
              child: Text(
                "New Entry",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        child: buildList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("masuk sini pertama");
    _moviesBase.deleteList();
    print("masuk sini kedua");
    _moviesBase.createMoviesList();
    print("masuk sini ketiga");

    // loadData();
  }
}