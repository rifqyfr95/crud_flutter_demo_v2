import 'package:auto_route/auto_route.dart';
import 'package:crud_flutter/screen/addTags.dart';
import 'package:crud_flutter/model/movies.dart';
import 'package:crud_flutter/state/moviesBase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router.gr.dart';

class EditMovies extends StatefulWidget {
  EditMovies({Key? key, required this.title, required this.type, this.movies})
      : super(key: key);
  String title;
  int type;
  Movies? movies;

  @override
  _EditMoviesState createState() => _EditMoviesState();
}

class _EditMoviesState extends State<EditMovies> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isTitleValid = false;
  bool _isDirectorValid = false;
  bool _isSummaryValid = false;
  bool _isTagsValid = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _directorController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();
  String data = "";
  String pk = "";
  List<String> listTags = <String>[];
  List<String> tagsChosen = <String>[];

  final _moviesBase = MoviesBase();

  Widget _buildTextFieldTitle() {
    return TextField(
      controller: _titleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Title",
        errorText:
            _isTitleValid == null || _isTitleValid ? null : "Title is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isTitleValid) {
          setState(() => _isTitleValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDirector() {
    return TextField(
      controller: _directorController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Director",
        errorText: _isDirectorValid == null || _isDirectorValid
            ? null
            : "Director name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isDirectorValid) {
          setState(() => _isDirectorValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldSummary() {
    return TextField(
      controller: _summaryController,
      keyboardType: TextInputType.name,
      minLines: 3,
      maxLines: 8,
      decoration: InputDecoration(
        labelText: "Summary",
        errorText: _isSummaryValid == null || _isSummaryValid
            ? null
            : "Summary is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isSummaryValid) {
          setState(() => _isSummaryValid = isFieldValid);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            child: IconButton(
              onPressed: () {
                AutoRouter.of(context)
                    .replace(MoviesListsRoute(title: "Movies"));
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          title: Text(widget.title),
          actions: widget.type == 0
              ? [
                  InkWell(
                    child: TextButton(
                        onPressed: () {
                          if (tagsChosen.isNotEmpty &&
                              _titleController.text.isNotEmpty &&
                              _directorController.text.isNotEmpty &&
                              _summaryController.text.isNotEmpty) {

                            String newTags = "";
                            tagsChosen.forEach((element) {
                              if (newTags.isEmpty) {
                                newTags = element;
                              } else {
                                newTags = newTags + "," + element;
                              }
                            });
                            String newData = _titleController.text +
                                "||" +
                                _directorController.text +
                                "||" +
                                _summaryController.text +
                                "||" +
                                newTags;
                            _moviesBase.inputMovies("", newData);
                            Future.delayed(new Duration(seconds: 3), () {
                              AutoRouter.of(context).replace(
                                  MoviesListsRoute(title: "Movies"));
                            });
                          } else {
                            final snackBar =
                                SnackBar(content: Text('Data is incomplete'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          setState(() {});
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ]
              : [
                  TextButton(
                      onPressed: () {
                        _moviesBase.deleteMovies(pk, data);
                        Future.delayed(new Duration(seconds: 3), () {
                          // AutoRouter.of(context).pop(true);
                          AutoRouter.of(context)
                              .replace(MoviesListsRoute(title: "Movies"));
                        });
                        setState(() {});
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        if (tagsChosen.isNotEmpty &&
                            _titleController.text.isNotEmpty &&
                            _directorController.text.isNotEmpty &&
                            _summaryController.text.isNotEmpty) {
                          String newTags = "";
                          tagsChosen.forEach((element) {
                            if (newTags.isEmpty) {
                              newTags = element;
                            } else {
                              newTags = newTags + "," + element;
                            }
                          });
                          String newData = _titleController.text +
                              "||" +
                              _directorController.text +
                              "||" +
                              _summaryController.text +
                              "||" +
                              newTags;
                          _moviesBase.inputMovies(pk, newData);
                          Future.delayed(new Duration(seconds: 3), () {
                            AutoRouter.of(context)
                                .replace(MoviesListsRoute(title: "Movies"));
                          });
                        } else {
                          final snackBar =
                              SnackBar(content: Text('Data is incomplete'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        setState(() {});
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ))
                ]),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFieldTitle(),
                SizedBox(height: 5),
                _buildTextFieldDirector(),
                SizedBox(height: 5),
                _buildTextFieldSummary(),
                SizedBox(height: 5),
                Text(
                  "Tags",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Wrap(
                    children: List.generate(
                        tagsChosen.length,
                        (index) => Container(
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.analytics,
                                            color: Colors.grey[600]),
                                        SizedBox(width: 10.0),
                                        Text(
                                          tagsChosen[index],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tagsChosen.removeAt(index);
                                        });
                                      },
                                      child:
                                          Icon(Icons.cancel, color: Colors.red))
                                ],
                              ),
                            )),
                    spacing: 15.0,
                    runSpacing: 10.0,
                  ),
                ),
                Visibility(
                  child: AddTags((tags) {
                    setState(() {
                      if (!tagsChosen.contains(tags)) {
                        tagsChosen.add(tags);
                      }
                    });
                  }, tagsChosen),
                  visible: tagsChosen.length < 7,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      _titleController.text = widget.movies!.title;
      _directorController.text = widget.movies!.director;
      _summaryController.text = widget.movies!.summary;
      List<String> tags = widget.movies!.tags.split(",");
      tagsChosen.addAll(tags);
      pk = widget.movies!.pk.toString();
      data = widget.movies!.pk.toString() +
          "||" +
          widget.movies!.title +
          "||" +
          widget.movies!.director +
          "||" +
          widget.movies!.summary +
          "||" +
          widget.movies!.tags;
    }
  }

}
