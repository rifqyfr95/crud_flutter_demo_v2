import 'package:auto_route/auto_route.dart';
import 'package:crud_flutter/model/movies.dart';
import 'package:crud_flutter/state/moviesBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../router.gr.dart';
import 'dart:async';

class MoviesLists extends StatefulWidget {
  MoviesLists({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MoviesListsState createState() => _MoviesListsState();
}

class _MoviesListsState extends State<MoviesLists> {
  final _moviesBase = MoviesBase();

  Widget buildList() {
    Timer timers = new Timer(Duration(seconds: 3), (){
      if(_moviesBase.listLength > 0){
        if(mounted){
          setState(() {

          });
        }
      }
    });
    if (_moviesBase.listLength != 0) {
      timers.cancel();
      return Observer(builder: (_)=>
          ListView.builder(
              itemCount: _moviesBase.lists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_moviesBase.lists[index].title),
                  subtitle: Text(_moviesBase.lists[index].director),
                  onTap: () {Movies movies = Movies(_moviesBase.lists[index].pk,
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
    _moviesBase.deleteList();
    _moviesBase.createMoviesList();
  }
}