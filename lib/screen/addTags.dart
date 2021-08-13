import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/painting.dart';

class AddTags extends StatefulWidget {
  final Function(String) listTags;
  final List<String> tagsUpdate;

  AddTags(this.listTags, this.tagsUpdate);

  @override
  _AddTagsState createState() => _AddTagsState();
}

class _AddTagsState extends State<AddTags> {
  TextEditingController tagsController = TextEditingController();

  // var _temporaryTags = <int,String>{};
  var _temporaryTagsList = <String>[];
  bool onDisable = true;

  void getTagsList() {
    _temporaryTagsList.add("Action");
    _temporaryTagsList.add("Horror");
    _temporaryTagsList.add("Comedy");
    _temporaryTagsList.add("Fantasy");
    _temporaryTagsList.add("Sci-Fi");
    _temporaryTagsList.add("Romance");
    _temporaryTagsList.add("Documentary");
  }

  @override
  Widget build(BuildContext context) {
    return onDisable
        ? Container(
            margin: EdgeInsets.only(left: 10.0),
            width: 50,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(3.0)),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    onDisable = !onDisable;
                  });
                },child: Text("Add Tags"),
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 10.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: true,
                controller: tagsController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Please pick a tags",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (tagsController.text.isNotEmpty) {
                          setState(() {
                            tagsController.clear();
                          });
                        } else {
                          setState(() {
                            onDisable = !onDisable;
                          });
                        }
                      },
                      icon: Icon(Icons.clear, color: Colors.grey),
                    )),
              ),
              hideOnEmpty: true,
              hideOnLoading: true,
              autoFlipDirection: true,
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) async {
                return await getSuggestionList(pattern);
              },
              itemBuilder: (context, suggest) {
                return ListTile(title: Text(suggest.toString()));
              },
              onSuggestionSelected: (suggest) {
                widget.listTags(suggest.toString());
                setState(() {
                  tagsController.clear();
                  onDisable = !onDisable;
                });
              },
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    getTagsList();
  }

  Future<List<String>> getSuggestionList(String pattern) async {
    var listFilter = <String>[];

    for (String x in _temporaryTagsList) {
      if (x.toLowerCase().contains(pattern.toLowerCase()) &&
          pattern.trim().isNotEmpty) {
        listFilter.add(x);
        print("Found " + pattern + " " + x);
      }
    }

    for (String x in widget.tagsUpdate) {
      if (listFilter.contains(x)) {
        listFilter.remove(x);
      }
    }
    return listFilter;
  }
}
