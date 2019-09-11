import 'package:flutter/material.dart';
import 'package:vocab_king/models/words.dart';
import 'package:vocab_king/requests/requests.dart';
import 'package:http/http.dart' as http;

class WordsTabPage extends StatefulWidget {
  @override
  _WordsTabPageState createState() => _WordsTabPageState();
}

class _WordsTabPageState extends State<WordsTabPage> {
  Future<List<Word>> wordsFuture;

  @override
  void initState() {
    super.initState();
    wordsFuture = getWords(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: wordsFuture,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(
            child: Icon(Icons.error),
          );
        }
        
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              String word = snapshot.data[i].value;
              List<Definition> definitions = snapshot.data[i].definitions;

              if(definitions.length > 1) {
                return ExpansionTile(
                  title: Text("$word (${definitions.length} definitions)"),
                  children: definitions.map((d) => ListTile(
                    title: Text(d.classification.value),
                    subtitle: Text(d.value),
                  )).toList(),
                );
              } else {
                return ListTile(
                  title: Text(word),
                  subtitle: Text(definitions[0].value),
                );
              }
            }
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}