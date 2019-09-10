import 'package:flutter/material.dart';
import 'package:vocab_king/models/stats.dart';
import 'package:vocab_king/models/words.dart';

class BasicPanel extends StatelessWidget {
  final String title;
  final void Function() expand;
  final Widget child;

  BasicPanel({Key key, this.title, this.expand, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
        child: Column(
            children: [
              Row(
                children: [
                  Text(title, style: TextStyle(fontSize: 16)),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    iconSize: 18,
                    onPressed: expand,
                  ),
                ],
              ),
              Divider(height: 5),
              child,
            ]
        ),
      )
    );
  }
}

class StatsPanel extends StatelessWidget {
  final StatsOverview statsOverview;

  StatsPanel({Key key, this.statsOverview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPanel(
      title: "Overview",
      expand: () => {},
      child: Table(
        children: [
          TableRow(
            children: [
              Padding(
                child: Text(statsOverview != null ? statsOverview.nWords.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 5, 5, 2.5),
              ),
              Padding(
                child: Text("words"),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 2.5),
              ),

              Padding(
                child: Text(statsOverview != null ? statsOverview.nPhrases.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 5, 5, 2.5),
              ),
              Padding(
                child: Text("phrases"),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 2.5),
              ),
            ]
          ),
          TableRow(
            children: [
              Padding(
                child: Text(statsOverview != null ? statsOverview.nDefinitions.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 5, 2.5),
              ),
              Padding(
                child: Text("definitions"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
              ),
              Padding(
                child: Text(statsOverview != null ? statsOverview.nTopics.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 5, 2.5),
              ),
              Padding(
                child: Text("topics"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
              )
            ],
          ),
          TableRow(
            children: [
              Padding(
                child: Text(statsOverview != null ? statsOverview.undefinedWords.length.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 5, 5),
              ),
              Padding(
                child: Text("undefined"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 0, 5),
              ),
              Padding(
                child: Text(statsOverview != null ? statsOverview.nNotes.toString() : "-"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 5, 5),
              ),
              Padding(
                child: Text("notes"),
                padding: EdgeInsets.fromLTRB(0, 2.5, 0, 5),
              )
            ],
          ),
        ],
      ),
    );
    /*
    return BasicPanel(
      title: "Overview",
      expand: () => {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(child: Text((statsOverview != null ? statsOverview.nWords.toString() : "-") + " words")),
              Card(child: Text((statsOverview != null ? statsOverview.nDefinitions.toString() : "-") + " definitions")),
              Card(child: Text((statsOverview != null ? statsOverview.undefinedWords.length.toString() : "-") + " undefined words")),
            ],
          ),
          Column(
            children: [
              Card(child: Text((statsOverview != null ? statsOverview.nPhrases.toString() : "-") + " phrases")),
              Card(child: Text((statsOverview != null ? statsOverview.nTopics.toString() : "-") + " topics")),
              Card(child: Text((statsOverview != null ? statsOverview.nNotes.toString() : "-") + " notes")),
            ],
          ),
        ],
      ),
    );
    */
  }
}

class UndefinedWordsPanel extends StatelessWidget {
  final List<Word> undefinedWords;

  UndefinedWordsPanel({Key key, this.undefinedWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPanel(
      title: "Words missing definitions",
      expand: () => {},
      child: undefinedWords == null ?
          Center(child: Text("-")) :
          Wrap(
            children: undefinedWords.map((w) {
              return Card(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(w.value),
                  ),
              );
            }).toList(),
          ),
    );
  }
}

class UntaggedWordsPanel extends StatelessWidget {
  final List<Word> untaggedWords;

  UntaggedWordsPanel({Key key, this.untaggedWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPanel(
      title: "Words missing tags",
      expand: () => {},
      child: untaggedWords == null ?
          Center(child: Text("-")) :
          Wrap(
            children: untaggedWords.map((w) {
              return Card(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(w.value),
                  ),
              );
            }).toList(),
          ),
    );
  }
}